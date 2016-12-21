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
    
    func actionWillStart()
    func actionWillStop()
}

final class ActionToolbar: NSToolbar {
    
    var actionDelegate: ActionToolbarDelegate?
    
    private var progressStatus: ProgressStatus = .None
    
    @IBOutlet private var progressIndicator: NSProgressIndicator!
    @IBOutlet private var loggingLabel: NSTextField!
    @IBOutlet private var startStopButton: NSButton!
    
    override func awakeFromNib() {
        progressIndicator.isHidden = true
    }
    
    // MARK: - Update UI
    
    func updateLogMessage(message: String) {
        DispatchQueue.main.async(execute: {
            self.loggingLabel.stringValue = message
        })
    }
    
    func jobIsDone() {
        progressIndicator.isHidden = true
        progressIndicator.stopAnimation(nil)
        loggingLabel.stringValue = String.empty
        progressStatus = .Success
        startStopButton.state = NSOnState
    }
    
    // MARK: - IBActions
    
    @IBAction func onStartStopButtomPress(sender: NSButton) {
        let previousState = sender.state
        
        if previousState == NSOnState {
            progressIndicator.isHidden = true
            progressIndicator.stopAnimation(nil)
            loggingLabel.stringValue = String.empty
            progressStatus = .Canceled
            actionDelegate?.actionWillStop()
        } else {
            progressIndicator.isHidden = false
            progressIndicator.startAnimation(nil)
            loggingLabel.stringValue = String.empty
            progressStatus = .None
            actionDelegate?.actionWillStart()
        }
    }
}
