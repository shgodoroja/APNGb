//
//  PreferencesTextFieldWithStepperCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/17/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesTextFieldWithStepperCellView: BaseTableCellView {
    
    override class func reuseIdentifier() -> String {
        return "preferences.sliderwithstepper.cellview"
    }
    
    override class func height() -> CGFloat {
        return 25
    }
}
