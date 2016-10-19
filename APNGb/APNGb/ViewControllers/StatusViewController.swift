//
//  StatusViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/13/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class StatusViewController: NSViewController {
    
    var cancelHandler: VoidHandler = nil
    
    @IBOutlet private var statusLabel: NSTextField!
    @IBOutlet private var progressIndicator: NSProgressIndicator!
    
    // MARK: - Life-cycle
    
    override func viewWillAppear() {
        progressIndicator.startAnimation(nil)
    }
    
    // MARK: - Update UI
    
    func updateStatusMessage(message: String) {
        statusLabel.stringValue = message
    }
    
    // MARK: - IBActions
    
    @IBAction func onCancel(_ sender: AnyObject) {
        progressIndicator.stopAnimation(nil)
        
        if let handler = cancelHandler {
            handler()
        } else {
            self.dismiss(nil)
        }
    }
}
