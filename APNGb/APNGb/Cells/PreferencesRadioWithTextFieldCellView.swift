//
//  PreferencesRadioWithTextFieldCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesRadioWithTextFieldCellView: BaseTableCellView {
    
    override class func reuseIdentifier() -> String {
        return "preferences.radiowithtextfield.cellview"
    }
    
    override class func height() -> CGFloat {
        return 25
    }
}
