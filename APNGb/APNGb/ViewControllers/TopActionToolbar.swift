//
//  TopActionToolbar.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/13/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum ProgressStatus {
    case Normal, Canceled
}

final class TopActionToolbar: NSToolbar {
    
    var cancelHandler: VoidHandler = nil
    
    private var progressStatus: ProgressStatus = .Normal
    
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
    
    // MARK: - Getters
    func actionWasCanceled() -> Bool {
        
        if progressStatus == .Canceled {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func onStartStopButtomPress(sender: NSButton) {
        let previousState = sender.state
        
        if previousState == NSOnState {
            progressIndicator.isHidden = true
            progressIndicator.stopAnimation(nil)
            progressStatus = .Canceled
            
            if let handler = cancelHandler {
                handler()
            }
            
        } else {
            progressIndicator.isHidden = false
            progressIndicator.startAnimation(nil)
            progressStatus = .Normal
            
        }
    }
}
