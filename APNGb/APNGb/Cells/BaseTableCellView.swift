//
//  BaseTableCellView.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

class BaseTableCellView: NSTableCellView {
    
    class func reuseIdentifier() -> String {
        assertionFailure("\(#function) must be overridden in subclass.")
        return String.empty
    }
    
    class func height() -> CGFloat {
        assertionFailure("\(#function) must be overridden in subclass.")
        return 0
    }
}
