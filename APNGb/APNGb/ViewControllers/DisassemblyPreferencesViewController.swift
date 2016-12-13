//
//  DisassemblyPreferencesViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

fileprivate enum Identifier: Int {
    
    case unknown
    
    enum TextField: Int {
        case frameName
    }
}

class DisassemblyPreferencesViewController: NSViewController {
    
    private var disassemblyArguments = DisassemblyArguments()
    
    @IBOutlet private var frameNamePrefixeTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: NSTextFieldDelegate
    
    override func controlTextDidChange(_ notification: Notification) {
        let textField = notification.object as? NSTextField
        let textFieldStringValue = textField?.stringValue
        
        if let textField = textField {
            
            switch textField.tag {
            case Identifier.TextField.frameName.rawValue:
                NSLog("\(#function): unhandled case")
            default:
                NSLog("\(#function): unhandled case")
            }
        }
    }
    
    private func collectTextFieldValues() {

    }
}
