//
//  StatusViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/13/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum ProgressStatus {
    case Normal, Canceled
}

final class StatusViewController: NSViewController {
    
    var cancelHandler: VoidHandler = nil
    
    private var progressStatus: ProgressStatus = .Normal
    
    @IBOutlet private var statusLabel: NSTextField!
    @IBOutlet private var progressIndicator: NSProgressIndicator!
    
    // MARK: - Life-cycle
    
    override func viewWillAppear() {
        progressIndicator.startAnimation(nil)
        progressStatus = .Normal
    }
    
    // MARK: - Update UI
    
    func updateStatusMessage(message: String) {
        DispatchQueue.main.async(execute: {
            self.statusLabel.stringValue = message
        })
    }
    
    // MARK: - Getters
    func wasCanceled() -> Bool {
        
        if progressStatus == .Canceled {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func onCancel(_ sender: AnyObject) {
        progressIndicator.stopAnimation(nil)
        progressStatus = .Canceled
        
        if let handler = cancelHandler {
            handler()
        }
        
        self.dismiss(nil)
    }
}
