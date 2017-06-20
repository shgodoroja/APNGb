//
//  PreferencesTextFieldCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesTextFieldCellView: BaseTableCellView {

    override class func reuseIdentifier() -> String {
        return "preferences.textfield.cellview"
    }
    
    override class func height() -> CGFloat {
        return 30
    }
}
