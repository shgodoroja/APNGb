//
//  MainWindowController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/16/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, ActionToolbarDelegate {
    
    private var process: ExecutableProcess?
        
    @IBOutlet private var actionToolbar: ActionToolbar!

    override func windowDidLoad() {
        super.windowDidLoad()
        self.hideWindowTitle()
        self.setupActionBar()
    }
    
    // MARK: ActionToolbarDelegate
    
    func actionWillStart() -> Bool {
        
        if let content = self.contentViewController as? MainContainerViewController {
            let executable = content.commandExecutable()
            let arguments = content.commandArguments().0
            let additionalData = content.commandArguments().1
            
            if content.havePassedValidation() {
                let command = Command(withExecutable: executable)
                command.arguments = arguments
                
                process = ExecutableProcessFactory.createProcess(identifiedBy: executable,
                                                                 and: command,
                                                                 withData: additionalData)
                process?.progressHandler = { output in
                #if DEBUG
                    debugPrint(output)
                #endif

                    // TODO: weak approach, must be refactored
                    let errorHasOccured = output.lowercased().contains("error")
                    
                    if errorHasOccured {
                        self.process?.cancelled = true
                    }
                    
                    self.actionToolbar.updateLogMessage(message: output)
                }
                process?.terminationHandler = {
                    self.actionToolbar.taskDone()
                    
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
            } else {
                self.actionToolbar.taskDone()
            }
        }
        
        return false
    }
    
    func actionWillStop() -> Bool {
        process?.cancelled = true
        process?.stop()
        
        return true
    }
    
    // MARK: Private
    
    private func hideWindowTitle() {
        self.window?.titleVisibility = .hidden
    }
    
    private func setupActionBar() {
        actionToolbar.actionDelegate = self
    }
    
    private func showSaveToDirectoryPanel(hintMessage: String,
                                          onOkButtonPressed: @escaping (URL?) -> ()?,
                                          onCancelButtonPressed: @escaping () -> ()?) {
        let openPanel = NSOpenPanel()
        openPanel.message = hintMessage
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.beginSheetModal(for: self.window!,
                                  completionHandler: { response in
                                    
                                    if response == NSFileHandlingPanelOKButton {
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
