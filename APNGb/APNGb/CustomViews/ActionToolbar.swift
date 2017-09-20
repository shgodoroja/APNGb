//
//  ActionToolbar.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/13/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum ProgressStatus {
    case None, Success, Canceled
}

protocol ActionToolbarDelegate {
    
    func actionWillStart() -> Bool
    func actionWillStop() -> Bool
}

final class ActionToolbar: NSToolbar {
    
    var actionDelegate: ActionToolbarDelegate?
    
    private var progressStatus: ProgressStatus = .None
    
    @IBOutlet private var progressIndicator: NSProgressIndicator!
    @IBOutlet private var loggingLabel: NSTextField!
    @IBOutlet private var startStopButton: NSButton!
    
    override func awakeFromNib() {
        progressIndicator.isHidden = true
        loggingLabel.stringValue = Resource.String.defaultToolbarLoggingMessage
    }
    
    // MARK: - Update UI
    
    func updateLogMessage(message: String) {
        DispatchQueue.main.async(execute: {
            self.loggingLabel.stringValue = message
        })
    }
    
    func taskDone() {
        self.setInProgressMode(false)
        progressStatus = .Success
        startStopButton.state = NSControl.StateValue.on
        loggingLabel.stringValue = Resource.String.defaultToolbarLoggingMessage
    }
    
    // MARK: - IBActions
    
    @IBAction func onStartStopButtomPress(sender: NSButton) {
        
        if sender.state == NSControl.StateValue.on {
            
            if actionDelegate?.actionWillStop() == true {
                self.setInProgressMode(false)
                progressStatus = .Canceled
                loggingLabel.stringValue = Resource.String.defaultToolbarLoggingMessage
            }
            
        } else {
            
            if actionDelegate?.actionWillStart() == true {
                self.setInProgressMode(true)
                progressStatus = .None
            }
        }
    }
    
    // MARK: Private
    
    private func setInProgressMode(_ inProgressMode: Bool) {
        progressIndicator.isHidden = inProgressMode ? false : true
        
        if inProgressMode {
            progressIndicator.startAnimation(nil)
        } else {
            progressIndicator.stopAnimation(nil)
        }
    }
}
