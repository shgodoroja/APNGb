//
//  ViewSize.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/10/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// Keeps dimension values of all views from the application.
struct ViewSize {
    
    static let windowHeight: CGFloat = 425.0
    static let windowWidth: CGFloat = 695.0
    static let splitViewSeparatorWidth: CGFloat = 1.0
}

extension ViewSize {
    
    /// Store side bar view dimension properties.
    struct SideBar {
        
        static let width: CGFloat = 50.0
    }
}

extension ViewSize {
    
    /// Store child container view dimension properties.
    struct ChildContainer {
        
        static let width: CGFloat = 425.0
    }
}

extension ViewSize {
    
    /// Store preferences view dimension properties.
    struct Preferences {
        
        static let width: CGFloat = 220.0
    }
}
