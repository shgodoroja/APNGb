//
//  PreferencesRadioWithTextField.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesRadioWithTextField: PreferencesOption {

    var title = String.empty
    var subtitle = String.empty
    var selected = false
    var value = 0
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(PreferencesRadioWithTextField.value) {
            value = 0
        }
    }
}
