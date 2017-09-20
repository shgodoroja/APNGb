//
//  PreferencesColorPicker.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesColorPicker: PreferencesOption {
    
    @objc var title = String.empty
    @objc var selected = false
    @objc var value = NSColor.clear
    @objc var comboOptions = [String]() {
        didSet {
            
            if let firstOption = comboOptions.first {
                title = firstOption
            }
        }
    }
}
