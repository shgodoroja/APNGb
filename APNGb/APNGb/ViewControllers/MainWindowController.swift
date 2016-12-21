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
    
    func actionWillStart() {
        let executable = (self.contentViewController as? CommandExecutableProtocol)?.commandExecutable()
        let arguments = (self.contentViewController as? CommandArgumentable)?.commandArguments()
        let argumentsPassedValidation = (self.contentViewController as? CommandArgumentable)?.havePassedValidation()
        
        if argumentsPassedValidation! {
            let command = Command(withExecutable: executable!)
            command.arguments = arguments
            
            process = DisassemblyProcess(withCommand: command)
            process?.progressHandler = { output in
                self.actionToolbar.updateLogMessage(message: output)
            }
            process?.terminationHandler = {
                self.actionToolbar.jobIsDone()
                (self.process as? DisassemblyProcess)?.showFrom(window: self.window!)
            }
            process?.start()
        } else {
            self.actionToolbar.jobIsDone()
        }
    }
    
    func actionWillStop() {
        process?.stop()
    }
    
    // MARK: Private
    
    private func hideWindowTitle() {
        self.window?.titleVisibility = .hidden
    }
    
    private func setupActionBar() {
        actionToolbar.actionDelegate = self
    }
}
