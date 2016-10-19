//
//  Optimization.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Optimization: CommandArguments {
    
    var enablePalette = true
    var enableColorType = true
    
    func commandArguments() -> [String] {
        var arguments: [String] = []
        
        if enablePalette == true {
            arguments.append("-kp")
        }
        
        if enableColorType == true {
            arguments.append("-kc")
        }
        
        return arguments
    }
    
}
