//
//  PreferencesColorPickerCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesColorPickerCellView: BaseTableCellView {
    
    override class func reuseIdentifier() -> String {
        return "preferences.color.cellview"
    }
    
    override class func height() -> CGFloat {
        return 25
    }
}
