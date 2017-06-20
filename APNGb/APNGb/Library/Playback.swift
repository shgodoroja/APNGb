//
//  Playback.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Playback: NSObject, CommandArgumentable {
    
    var numberOfLoops = 0
    var skipFirstFrame = false
    
    // MARK: - CommandArgumentable
    
    func validated() -> Bool {
        return true
    }
    
    func arguments() -> [String] {
        var arguments = [String]()
        
        if numberOfLoops > 0 {
            arguments.append(Argument.numberOfLoops + "\(numberOfLoops)")
        }
        
        if skipFirstFrame == true {
            arguments.append(Argument.skipFirstFrame)
        }
        
        return arguments
    }
}
