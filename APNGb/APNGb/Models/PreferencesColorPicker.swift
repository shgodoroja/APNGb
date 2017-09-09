//
//  PreferencesColorPicker.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesColorPicker: PreferencesOption {
    
    var title = String.empty
    var selected = false
    var value = NSColor.clear
    var comboOptions = [String]() {
        didSet {
            
            if let firstOption = comboOptions.first {
                //comboValue = firstOption
            }
        }
    }
}
