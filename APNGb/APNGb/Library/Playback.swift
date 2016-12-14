//
//  Playback.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Playback: CommandArgumenting {
    
    var numberOfLoops = 0
    var skipFirstFrame = false
    
    func commandArguments() -> [String] {
        var arguments: [String] = []
        
        if numberOfLoops > 0 {
            arguments.append("-l\(numberOfLoops)")
        }
        
        if skipFirstFrame == true {
            arguments.append("-f")
        }
        
        return arguments
    }
}
