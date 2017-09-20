//
//  PreferencesCheckbox.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesCheckbox: PreferencesOption {

    @objc var title = String.empty
    @objc var selected = false
    
    override func getValue() -> String? {
        return String(selected)
    }
}
