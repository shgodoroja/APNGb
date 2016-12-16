//
//  DropHintViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/8/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DropHintViewController: NSViewController {

    @IBOutlet private var hintLabel: NSTextField!
    
    var hintMessage = String.empty {
        
        didSet {
            hintLabel.stringValue = hintMessage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableDraggingForAllViews()        
    }
    
    // MARK: Private
    
    private func disableDraggingForAllViews() {
        self.view.unregisterDraggedTypes()
        
        for view in self.view.subviews {
            view.unregisterDraggedTypes()
        }
    }
}
