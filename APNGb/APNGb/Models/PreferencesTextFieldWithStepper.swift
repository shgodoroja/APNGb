//
//  PreferencesTextFieldWithStepper.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/17/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

class PreferencesTextFieldWithStepper: PreferencesOption {

    var title = String.empty
    var value = 0
    var selected = false
    var stepperMinValue = 0
    var stepperMaxValue = 0
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(PreferencesTextFieldWithStepper.value) {
            value = 0
        }
    }
}
