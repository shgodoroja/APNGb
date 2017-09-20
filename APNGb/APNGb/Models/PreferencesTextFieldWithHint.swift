//
//  PreferencesTextFieldWithHint.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesTextFieldWithHint: PreferencesOption {
    
    @objc var title = String.empty
    @objc var hint = String.empty
    @objc var value = 0
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(PreferencesTextFieldWithHint.value) {
            value = 0
        }
    }
    
    override func getIdentifier() -> ParameterIdentifier {
        return identifier
    }
    
    override func getValue() -> String? {
        return String(value)
    }
}
