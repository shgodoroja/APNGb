//
//  PreferencesComboWithTextFieldCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesComboWithTextFieldCellView: BaseTableCellView {
    
    override class func reuseIdentifier() -> String {
        return "preferecens.combowithtextfield.cellview"
    }
    
    override class func height() -> CGFloat {
        return 25
    }
}
