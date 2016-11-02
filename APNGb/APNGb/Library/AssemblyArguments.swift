//
//  AssemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyArguments: CommandArguments {
    
    var destinationImagePath = AssemblyArguments.defaultArgumentValue()
    var sourceImagePath = AssemblyArguments.defaultArgumentValue()

    var playback: Playback
    var optimization: Optimization
    var compression: Compression
    var allFramesDelay: FrameDelay
    var selectedFramesDelay: FrameDelay
    
    init() {
        playback = Playback()
        optimization = Optimization()
        compression = Compression()
        allFramesDelay = FrameDelay()
        selectedFramesDelay = FrameDelay(withCategory: .Selected, andState: false)
    }
    
    func havePassedValidation() -> Bool {
        let arguments = commandArguments()
        
        for argument in arguments {
            
            if argument == AssemblyArguments.defaultArgumentValue() {
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
