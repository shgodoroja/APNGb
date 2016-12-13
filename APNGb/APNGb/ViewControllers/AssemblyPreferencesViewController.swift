//
//  AssemblyPreferencesViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

fileprivate enum Identifier: Int {
    
    case unknown
    
    enum Checkbox: Int {
        case skip, palette, color
    }
    
    enum RadioButton: Int {
        case zlib, sevenZip, zopfli
    }
    
    enum TextField: Int {
        case numberOfLoops, sevenZipIterations, zopfliIterations, allFramesDelaySeconds
        case allframesDelayFrames, selectedDelaySeconds, selectedDelayFrames
    }
}

class AssemblyPreferencesViewController: NSViewController {
    
    private var assemblyArguments = AssemblyArguments()
    
    // Checkboxes
    @IBOutlet private var skipFirstFrameCheckbox: NSButton!
    @IBOutlet private var paletteCheckbox: NSButton!
    @IBOutlet private var colorTypeCheckbox: NSButton!
    
    // RadioButtons
    @IBOutlet private var zlibRadioButton: NSButton!
    @IBOutlet private var sevenZipRadioButton: NSButton!
    @IBOutlet private var zopfliRadioButton: NSButton!
    
    // TextFields
    @IBOutlet private var numberOfLoopsTextField: NSTextField!
    @IBOutlet private var sevenZipIterationsTextField: NSTextField!
    @IBOutlet private var zopfliIterationsTextField: NSTextField!
    @IBOutlet private var allFramesDelaySecondsTextField: NSTextField!
    @IBOutlet private var allframesDelayFramesTextField: NSTextField!
    @IBOutlet private var selectedDelaySecondsTextField: NSTextField!
    @IBOutlet private var selectedDelayFramesTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonsIdentifiers()
    }
    
    // MARK: RadioButton action
    
    @IBAction func didSelectRadioButton(_ sender: NSButton) {
        
        switch sender.tag {
        case Identifier.RadioButton.zlib.rawValue:
            assemblyArguments.compression.enableZlib = Bool(sender.state)
        case Identifier.RadioButton.sevenZip.rawValue:
            assemblyArguments.compression.enable7zip = Bool(sender.state)
        case Identifier.RadioButton.zopfli.rawValue:
            assemblyArguments.compression.enableZopfli = Bool(sender.state)
        default:
            print("\(#function): unhandled case")
        }
        
        self.updateRadioButtonAssociatedTextFields()
    }
    
    // MARK: Checkbox action
    
    @IBAction func didSelectCheckbox(_ sender: NSButton) {
        
        switch sender.tag {
        case Identifier.Checkbox.skip.rawValue:
            assemblyArguments.playback.skipFirstFrame = Bool(sender.state)
        case Identifier.Checkbox.palette.rawValue:
            assemblyArguments.optimization.enablePalette = Bool(sender.state)
        case Identifier.Checkbox.color.rawValue:
            assemblyArguments.optimization.enableColorType = Bool(sender.state)
        default:
            print("\(#function): unhandled case")
        }
    }
    
    // MARK: NSTextFieldDelegate
    
    override func controlTextDidChange(_ notification: Notification) {
        let textField = notification.object as? NSTextField
        let textFieldIntegerValue = textField?.integerValue
        
        if let textField = textField {
            
            switch textField.tag {
            case Identifier.TextField.numberOfLoops.rawValue:
                NSLog("\(#function): unhandled case")
            case Identifier.TextField.selectedDelaySeconds.rawValue:
                NSLog("\(#function): unhandled case")
            case Identifier.TextField.selectedDelayFrames.rawValue:
                NSLog("\(#function): unhandled case")
            case Identifier.TextField.allFramesDelaySeconds.rawValue:
                NSLog("\(#function): unhandled case")
            case Identifier.TextField.allframesDelayFrames.rawValue:
                NSLog("\(#function): unhandled case")
            default:
                NSLog("\(#function): unhandled case")
            }
        }
        
//        if textField == selectedDelaySecondsTextField {
//            let seconds = textField?.integerValue
//            
//            if let indexes = selectedImagesIndexSet {
//                
//                for index in indexes {
//                    droppedImages[index].delaySeconds = seconds!
//                }
//            }
//            
//        } else if textField == selectedDelayFramesTextField {
//            let frames = textField?.integerValue
//            
//            if let indexes = selectedImagesIndexSet {
//                
//                for index in indexes {
//                    droppedImages[index].delayFrames = frames!
//                }
//            }
//        } else if textField == allFramesDelaySecondsTextField {
//            let seconds = textField?.integerValue
//            
//            for droppedImage in droppedImages {
//                droppedImage.delaySeconds = seconds!
//            }
//            
//        } else if textField == allframesDelayFramesTextField {
//            let frames = textField?.integerValue
//            
//            for droppedImage in droppedImages {
//                droppedImage.delayFrames = frames!
//            }
//        }
        
    }
    
    // MARK: Private
    
    private func setButtonsIdentifiers() {
        skipFirstFrameCheckbox.tag =  Identifier.Checkbox.skip.rawValue
        paletteCheckbox.tag = Identifier.Checkbox.palette.rawValue
        colorTypeCheckbox.tag = Identifier.Checkbox.color.rawValue
        zlibRadioButton.tag = Identifier.RadioButton.zlib.rawValue
        sevenZipRadioButton.tag = Identifier.RadioButton.sevenZip.rawValue
        zopfliRadioButton.tag = Identifier.RadioButton.zopfli.rawValue
        numberOfLoopsTextField.tag = Identifier.TextField.numberOfLoops.rawValue
        sevenZipIterationsTextField.tag = Identifier.TextField.sevenZipIterations.rawValue
        zopfliIterationsTextField.tag = Identifier.TextField.zopfliIterations.rawValue
        allframesDelayFramesTextField.tag = Identifier.TextField.allframesDelayFrames.rawValue
        allFramesDelaySecondsTextField.tag = Identifier.TextField.allFramesDelaySeconds.rawValue
        selectedDelayFramesTextField.tag = Identifier.TextField.selectedDelayFrames.rawValue
        selectedDelaySecondsTextField.tag = Identifier.TextField.selectedDelaySeconds.rawValue
    }
    
    private func collectTextFieldValues() {
        assemblyArguments.playback.numberOfLoops = numberOfLoopsTextField.integerValue
        assemblyArguments.compression.sevenZipIterations = sevenZipIterationsTextField.integerValue
        assemblyArguments.compression.zopfliIterations = zopfliIterationsTextField.integerValue
        assemblyArguments.allFramesDelay.seconds = allFramesDelaySecondsTextField.integerValue
        assemblyArguments.allFramesDelay.frames = allframesDelayFramesTextField.integerValue
        assemblyArguments.selectedFramesDelay.seconds = selectedDelaySecondsTextField.integerValue
        assemblyArguments.selectedFramesDelay.frames = selectedDelayFramesTextField.integerValue
    }
    
    private func updateRadioButtonAssociatedTextFields() {
        sevenZipIterationsTextField.isEnabled = assemblyArguments.compression.enable7zip
        zopfliIterationsTextField.isEnabled = assemblyArguments.compression.enableZopfli
    }
}
