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
    
    func present(scene: Scene) {
        childContainerViewController?.addChildViewController(forScene: scene)
        preferencesPaneViewController?.showPreferences(forScene: scene)
    }
    
    // MARK: ActionToolbarDelegate
    
    func actionWillStart() -> Bool {
        
        if let mainViewController = NSApplication.shared.mainWindow?.windowController as? MainWindowController {
            let actionToolbar = mainViewController.actionToolbar
            let scene = preferencesPaneViewController?.scene
            var executable = CommandExecutable.none
            
            // 1.
            
            switch scene! {
            case .Assembly:
                executable = .assembly
            case .Disassembly:
                executable = .disassembly
            case .Optimize:
                executable = .optimize
            case .ConvertApng:
                executable = .convertApng
            case .ConvertGif:
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
        present(scene: .Assembly)
    }
    
    private func setupChildViewControllers() {
        let viewLayout = MainContainerViewLayout()
        
        for childViewController in self.childViewControllers {
            
            if childViewController is SideBarViewController {
                sideBarViewController = childViewController as? SideBarViewController
                
                if let view = sideBarViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayout.update(view,
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
                        viewLayout.update(view,
                                          withIdentifier: .ChildContainer,
                                          superview: superview,
                                          andSiblingView: sideBarViewController?.view)
                    }
                }
                
            } else if childViewController is PreferencesPaneViewController {
                preferencesPaneViewController = childViewController as? PreferencesPaneViewController
                
                if let view = preferencesPaneViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayout.update(view,
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
