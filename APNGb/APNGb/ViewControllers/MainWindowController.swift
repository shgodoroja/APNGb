//
//  MainWindowController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/16/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
        
    @IBOutlet private var actionToolbar: TopActionToolbar!

    override func windowDidLoad() {
        super.windowDidLoad()
        self.hideWindowTitle()
        self.setupActionBarHandlers()
    }
    
    // MARK: Private
    
    private func hideWindowTitle() {
        self.window?.titleVisibility = .hidden
    }
    
    private func setupActionBarHandlers() {
        // TODO: Set-up handlers
    }
}
