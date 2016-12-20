//
//  AssemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyArguments: NSObject, CommandArgumentable {
    
    var destinationImagePath = String.empty
    var sourceImagePath = String.empty

    var playback: Playback
    var optimization: Optimization
    var compression: Compression
    var allFramesDelay: FrameDelay
    var selectedFramesDelay: FrameDelay
    
    override init() {
        playback = Playback()
        optimization = Optimization()
        compression = Compression()
        allFramesDelay = FrameDelay()
        selectedFramesDelay = FrameDelay(withCategory: .Selected,
                                         andState: false)
    }
    
    // MARK: CommandArgumentable
    
    func havePassedValidation() -> Bool {
        let arguments = commandArguments()
        
        for argument in arguments {
            
            if argument == String.empty {
                return false
            }
        }
        
        return true
    }
    
    func commandArguments() -> [String] {
        var arguments: [String] = [destinationImagePath, sourceImagePath]
        arguments.append(contentsOf: playback.commandArguments())
        arguments.append(contentsOf: optimization.commandArguments())
        arguments.append(contentsOf: compression.commandArguments())
        
        return arguments
    }
}
