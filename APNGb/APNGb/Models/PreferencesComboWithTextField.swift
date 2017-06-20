//
//  PreferencesComboWithTextField.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesComboWithTextField: PreferencesOption {
    
    var value = 0
    var selected = false
    var comboValue = String.empty
    var comboContent = [String]() {
        didSet {
            
            if let firstObject = comboContent.first {
                comboValue = firstObject
            }
        }
    }
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(PreferencesComboWithTextField.value) {
            value = 0
        }
    }
}
