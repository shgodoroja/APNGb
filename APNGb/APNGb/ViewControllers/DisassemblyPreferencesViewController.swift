//
//  DisassemblyPreferencesViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyPreferencesViewController: NSViewController {
    
    dynamic var disassemblyArguments: DisassemblyArguments!
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.Color.preferencesPane
    }
}
