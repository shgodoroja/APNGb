//
//  AssemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyArguments: NSObject, CommandArgumentable, CommandExecutableProtocol {
    
    var frameNamePrefix = "apng-frame"
    var playback: Playback
    var optimization: Optimization
    var compression: Compression
    var allFramesDelay: FrameDelay
    var selectedFramesDelay: FrameDelay
    
    var animationFrames = [AnimationFrame]() {
        
        didSet {
            
            if animationFrames.count == 0 {
                animatedImagePath = String.empty
            } else {
                animatedImagePath = "url-path"
            }
        }
    }
    
    private var animatedImagePath = String.empty
        
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
        let arguments = commandArguments().0
        
        for argument in arguments {
            
            if argument == String.empty {
                return false
            }
        }
        
        return true
    }
    
    func commandArguments() -> ([String], Any?) {
        var arguments: [String] = [animatedImagePath, frameNamePrefix]
        arguments.append(contentsOf: playback.commandArguments().0)
        arguments.append(contentsOf: optimization.commandArguments().0)
        arguments.append(contentsOf: compression.commandArguments().0)
        
        return (arguments, animationFrames)
    }
    
    // MARK: CommandExecutableProtocol 
    
    func commandExecutable() -> CommandExecutable {
        return .assembly
    }
}
