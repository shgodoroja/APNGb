//
//  PreferencesSectionHeaderCellView.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/13/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesSectionHeaderCellView: BaseTableCellView {
    
    override class func reuseIdentifier() -> String {
        return "preferences.sectionheader.cellview"
    }
    
    override class func height() -> CGFloat {
        return 25
    }
}
