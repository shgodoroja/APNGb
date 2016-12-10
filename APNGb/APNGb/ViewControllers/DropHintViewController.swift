//
//  DropHintViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/8/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DropHintViewController: NSViewController {

    var hintMessage = String.empty {
        
        didSet {
            hintLabel.stringValue = hintMessage
        }
    }
    
    @IBOutlet private var hintLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}
