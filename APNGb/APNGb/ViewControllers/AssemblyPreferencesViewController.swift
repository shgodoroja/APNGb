//
//  AssemblyPreferencesViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyPreferencesViewController: NSViewController {
    
    private dynamic var assemblyArguments = AssemblyArguments()
    
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
    
    // MARK: Private
    
    private func updateRadioButtonAssociatedTextFields() {
        sevenZipIterationsTextField.isEnabled = assemblyArguments.compression.enable7zip
        zopfliIterationsTextField.isEnabled = assemblyArguments.compression.enableZopfli
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.Color.preferencesPane
    }
}
