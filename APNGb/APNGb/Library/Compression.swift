//
//  Compression.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Compression: CommandArguments {
    
    var enableZlib = false
    var enable7zip = true
    var _7zipIterations = 15
    var enableZopfli = false
    var zopfliIterations = 15
    
    func commandArguments() -> [String] {
        var arguments: [String] = []
        
        if enableZlib == true {
            arguments.append("-z0")
        }
        
        if enable7zip == true {
            arguments.append("-z1")
            arguments.append("-i\(_7zipIterations)")
        }
        
        if enableZopfli == true {
            arguments.append("-z2")
            arguments.append("-i\(zopfliIterations)")
        }
        
        return arguments
    }
}
