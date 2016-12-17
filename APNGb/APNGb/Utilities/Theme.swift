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
    struct Color {
        
        static let sidebarBackground = Theme.workingPaneColor
        static let preferencesPane = Theme.workingPaneColor
    }
}
