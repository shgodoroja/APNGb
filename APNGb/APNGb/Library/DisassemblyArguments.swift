//
//  DisassemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyArguments: NSObject, CommandArgumentable, CommandExecutableProtocol {
    
    var animatedImagePath = String.empty
    var framesNamePrefix = "frame"
    
    // MARK: - CommandArgumenting
    
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
        return ([animatedImagePath, framesNamePrefix], nil)
    }
    
    // MARK: CommandExecutableProtocol
    
    func commandExecutable() -> CommandExecutable {
        return .disassembly
    }
}
