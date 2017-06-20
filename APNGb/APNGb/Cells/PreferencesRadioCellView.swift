//
//  PreferencesRadioCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesRadioCellView: BaseTableCellView {
        
    override class func reuseIdentifier() -> String {
        return "preferences.radio.cellview"
    }
    
    override class func height() -> CGFloat {
        return 25
    }
}
