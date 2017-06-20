//
//  PreferencesCheckbox.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesCheckbox: PreferencesOption {

    var title = String.empty
    var selected = false
    
    override func getValue() -> String? {
        return String(selected)
    }
}
