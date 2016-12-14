//
//  Compression.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Compression: NSObject, CommandArgumenting {
    
    var enableZlib = false {
        
        didSet {
            
            if enableZlib == true {
                enable7zip = false
                enableZopfli = false
            }
        }
    }
    
    var enable7zip = true {
        
        didSet {
            
            if enable7zip == true {
                enableZlib = false
                enableZopfli = false
            }
        }
    }
    
    var enableZopfli = false {
        
        didSet {
            
            if enableZopfli == true {
                enable7zip = false
                enableZlib = false
            }
        }
    }
    
    var sevenZipIterations = 15
    var zopfliIterations = 15
    
    func commandArguments() -> [String] {
        var arguments: [String] = []
        
        if enableZlib == true {
            arguments.append("-z0")
        }
        
        if enable7zip == true {
            arguments.append("-z1")
            arguments.append("-i\(sevenZipIterations)")
        }
        
        if enableZopfli == true {
            arguments.append("-z2")
            arguments.append("-i\(zopfliIterations)")
        }
        
        return arguments
    }
}
