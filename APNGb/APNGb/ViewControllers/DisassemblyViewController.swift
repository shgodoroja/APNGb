//
//  DisassemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyViewController: NSViewController {
    
    private var executableHandler: ExecutableHandler?
    
    @IBOutlet private var filePathLabel: NSTextField!
    @IBOutlet private var filePathTextField: NSTextField!
    @IBOutlet private var fileNamePrefixLabel: NSTextField!
    @IBOutlet private var fileNameTextField: NSTextField!
    @IBOutlet private var statusLabel: NSTextField!
    @IBOutlet private var statusProgress: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        executableHandler = ExecutableHandler(withExecutableIdentifier: .Disassembly)
    }
    
    // MARK: IBActions
    
    @IBAction func selectFile(_ sender: AnyObject) {
        
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = false
        
        let currentWindow = self.view.window
        
        panel.beginSheetModal(for: currentWindow!) { status  in
            
            if status == NSFileHandlingPanelOKButton {
                print("url: \(panel.url)")
            }
        }
    }
    
    @IBAction func startDisassemblingProcess(_ sender: AnyObject) {
        
        
    }
    
}
