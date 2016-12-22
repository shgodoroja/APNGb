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
        let executable = (self.contentViewController as? CommandExecutableProtocol)?.commandExecutable()
        let arguments = (self.contentViewController as? CommandArgumentable)?.commandArguments()
        let argumentsPassedValidation = (self.contentViewController as? CommandArgumentable)?.havePassedValidation()
        
        if argumentsPassedValidation == true {
            let command = Command(withExecutable: executable!)
            command.arguments = arguments
            
            process = DisassemblyProcess(withCommand: command)
            process?.progressHandler = { output in
                self.actionToolbar.updateLogMessage(message: output)
            }
            process?.terminationHandler = {
                self.actionToolbar.taskDone()
                
                if self.process?.cancelled == false {
                    (self.process as? DisassemblyProcess)?.showFrom(window: self.window!)
                } else {
                    self.process?.cancelled = false
                    self.process?.cleanup()
                }
            }
            
            process?.start()
            
            return true
            
        } else {
            self.actionToolbar.taskDone()
            
            return false
        }
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
}
