//
//  DisassemblyPreferencesViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyPreferencesViewController: NSViewController {
    
    private dynamic var disassemblyArguments = DisassemblyArguments()
    
    @IBOutlet private var frameNamePrefixeTextField: NSTextField!
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.Color.preferencesPane
    }
}
