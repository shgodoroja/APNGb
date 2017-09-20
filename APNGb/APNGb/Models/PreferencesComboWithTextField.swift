//
//  PreferencesComboWithTextField.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesComboWithTextField: PreferencesOption {
    
    @objc var hint = String.empty
    @objc var value = 0
    @objc var comboValue = String.empty
    @objc var comboOptions = [String]() {
        didSet {
            
            if let firstOption = comboOptions.first {
                comboValue = firstOption
            }
        }
    }
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(PreferencesComboWithTextField.value) {
            value = 0
        }
    }
}
