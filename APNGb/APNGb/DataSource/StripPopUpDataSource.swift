//
//  StripPopUpDataSource.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/26/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum StripOrientation: String  {
    case vertical = "Vertical"
    case horizontal = "Horizontal"
    case none = "None"
    
    static func argumentValue(for orientation: String) -> String {
        
        if orientation == vertical.rawValue {
            return Argument.verticalStrip
        } else if orientation == horizontal.rawValue {
            return Argument.horizontalStrip
        }  else {
            return String.empty
        }
    }
}

class StripPopUpDataSource: NSObject {
    
    let orientations = [StripOrientation.none.rawValue,
                        StripOrientation.vertical.rawValue,
                        StripOrientation.horizontal.rawValue]
}
