//
//  Compression.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Compression: NSObject, CommandArgumentable {
    
    var enableZlib = false
    var enable7zip = false
    var enableZopfli = false
    var sevenZipIterations = 0
    var zopfliIterations = 0
    
    // MARK: - CommandArgumentable
    
    func validated() -> Bool {
        return true
    }
    
    func arguments() -> [String] {
        var arguments = [String]()
        
        if enableZlib == true {
            arguments.append(Argument.enableZlib)
        }
        
        if enable7zip == true {
            arguments.append(Argument.enable7zip)
            arguments.append(Argument.iteration + "\(sevenZipIterations)")
        }
        
        if enableZopfli == true {
            arguments.append(Argument.enableZopfli)
            arguments.append(Argument.iteration + "\(zopfliIterations)")
        }
        
        return arguments
    }
}
