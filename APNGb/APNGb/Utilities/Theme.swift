//
//  Theme.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/17/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

struct Theme {
    
    private static let workingPaneColor = NSColor(colorLiteralRed: 246 / 255,
                                                  green: 246 / 255,
                                                  blue: 246 / 255,
                                                  alpha: 1.0)
    
    private static let selectedCellBorderColor = NSColor(calibratedWhite: 0.65,
                                                         alpha: 1)
    private static let selectedCellBackgroundColor = NSColor(calibratedWhite: 0.82,
                                                             alpha: 1)
    
    struct Color {
        
        static let sidebarBackground = Theme.workingPaneColor
        static let preferencesPane = Theme.workingPaneColor
        static let assemblyFrameCellBorderColor = Theme.selectedCellBorderColor
        static let assemblyFrameCellBackgroundColor = Theme.selectedCellBackgroundColor
    }
}
