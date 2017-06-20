//
//  PreferencesTextFieldWithHintCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/13/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesTextFieldWithHintCellView: BaseTableCellView {
    
    override class func reuseIdentifier() -> String {
        return "preferences.textfieldwithhind.cellview"
    }
    
    override static func height() -> CGFloat {
        return 45
    }
}
