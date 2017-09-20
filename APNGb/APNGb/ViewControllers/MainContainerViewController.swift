//
//  MainContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/6/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class MainContainerViewController: NSSplitViewController, ScenePresentable, ActionToolbarDelegate {
    
    private var process: ExecutableProcess?
    private var sideBarViewController: SideBarViewController?
    private var childContainerViewController: ChildContainerViewController?
    private var preferencesPaneViewController: PreferencesPaneViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildViewControllers()
        self.presentInitialChildViewControllers()
    }
    
    override func viewDidAppear() {
        
        if let mainViewController = self.view.window?.windowController as? MainWindowController {
            mainViewController.actionToolbar.actionDelegate = self
        }
        
        super.viewDidAppear()
    }
    
    // MARK: - ScenePresentable
    
    func presentScene(withIdentifier identifier: MainScene) {
        childContainerViewController?.addChildViewControllerForScene(withIdentifier: identifier)

        if identifier == .ConvertScene {
            // Pass unknown identifier. When animated image will be dropped, depend on it's 
            // extension (gif or png/apng) preferences will be displayed.
            preferencesPaneViewController?.showPreferencesForScene(withIdentifier: .UnknownScene)
        } else {
            preferencesPaneViewController?.showPreferencesForScene(withIdentifier: identifier)
        }
    }
    
    // MARK: ActionToolbarDelegate
    
    func actionWillStart() -> Bool {
        
        if let mainViewController = NSApplication.shared.mainWindow?.windowController as? MainWindowController {
            let actionToolbar = mainViewController.actionToolbar
            let sceneIdentifier = preferencesPaneViewController?.sceneIdentifier
            var executable = CommandExecutable.none
            
            // 1.
            
            switch sceneIdentifier! {
            case .AssemblyScene:
                executable = .assembly
            case .DisassemblyScene:
                executable = .disassembly
            case .OptimizeScene:
                executable = .optimize
            case .ConvertApngScene:
                executable = .convertApng
            case .ConvertGifScene:
                executable = .convertGif
            default:
                executable = .none
            }
            
            // 2.
            
            //var s = childContainerViewController?.params()
            let s = preferencesPaneViewController?.params()
            //s?.append(g)
            
            let transformer = ArgumentTransformer()
            let arguments = transformer.arguments(fromParameters: s!)
            
            let command = Command(withExecutable: executable)
            command.arguments = arguments
            process = ExecutableProcessFactory.createProcess(identifiedBy: executable,
                                                             and: command)
            process?.progressHandler = { output in
                #if DEBUG
                    debugPrint(output)
                #endif
                // TODO: weak approach, must be refactored
                let errorHasOccured = output.lowercased().contains("error")
                
                if errorHasOccured {
                    self.process?.cancelled = true
                }
                
                actionToolbar?.updateLogMessage(message: output)
            }
            process?.terminationHandler = {
                actionToolbar?.taskDone()
                
                if self.process?.cancelled == false {
                    let onOkButtonPressedHandler = { url in
                        self.process?.didFinishedWithSuccess(success: true,
                                                             url: url)
                    }
                    let onCancelButtonPressedHandler = {
                        self.process?.didFinishedWithSuccess(success: false,
                                                             url: nil)
                    }
                    let hintMessage = self.hintMessageForProcess(process: self.process)
                    self.showSaveToDirectoryPanel(hintMessage: hintMessage,
                                                  onOkButtonPressed: onOkButtonPressedHandler,
                                                  onCancelButtonPressed: onCancelButtonPressedHandler)
                } else {
                    self.process?.cancelled = false
                    self.process?.cleanup()
                }
            }
            process?.start()
            
            return true
        }
        
        return false
    }
    
    func actionWillStop() -> Bool {
        process?.cancelled = true
        process?.stop()
        
        return true
    }
    
    // MARK: - Private
    
    private func presentInitialChildViewControllers() {
        presentScene(withIdentifier: .AssemblyScene)
    }
    
    private func setupChildViewControllers() {
        let viewLayoutCareTaker = MainContainerViewLayoutCareTaker()
        
        for childViewController in self.childViewControllers {
            
            if childViewController is SideBarViewController {
                sideBarViewController = childViewController as? SideBarViewController
                
                if let view = sideBarViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayoutCareTaker.updateLayoutOf(view,
                                                           withIdentifier: .SideBar,
                                                           superview: superview,
                                                           andSiblingView: nil)
                    }
                }
                
                sideBarViewController?.delegate = self
            } else if childViewController is ChildContainerViewController {
                childContainerViewController = childViewController as? ChildContainerViewController
                
                if let view = childContainerViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayoutCareTaker.updateLayoutOf(view,
                                                           withIdentifier: .ChildContainer,
                                                           superview: superview,
                                                           andSiblingView: sideBarViewController?.view)
                    }
                }
                
            } else if childViewController is PreferencesPaneViewController {
                preferencesPaneViewController = childViewController as? PreferencesPaneViewController
                
                if let view = preferencesPaneViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayoutCareTaker.updateLayoutOf(view,
                                                           withIdentifier: .PreferencesPane,
                                                           superview: superview,
                                                           andSiblingView: childContainerViewController?.view)
                    }
                }
            }
        }
    }
    
    private func showSaveToDirectoryPanel(hintMessage: String,
                                          onOkButtonPressed: @escaping (URL?) -> ()?,
                                          onCancelButtonPressed: @escaping () -> ()?) {
        let openPanel = NSOpenPanel()
        openPanel.message = hintMessage
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.beginSheetModal(for: self.view.window!,
                                  completionHandler: { response in

                                    if response == NSApplication.ModalResponse.OK {
                                        let destinationDirectoryUrl = openPanel.urls[0]
                                        onOkButtonPressed(destinationDirectoryUrl)
                                    } else {
                                        onCancelButtonPressed()
                                    }
        })
    }
    
    private func hintMessageForProcess(process: ExecutableProcess?) -> String {
        
        if process is AssemblyProcess {
            return Resource.String.selectFolderToSaveAnimatedImage
        } else if process is DisassemblyProcess {
            return Resource.String.selectFolderToSaveFrames
        } else {
            return String.empty
        }
    }
}
