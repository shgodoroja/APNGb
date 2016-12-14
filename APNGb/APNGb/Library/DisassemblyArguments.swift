//
//  DisassemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyArguments: CommandArgumenting {
    
    var frameNamePrefix = String.empty
    
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
        return [frameNamePrefix]
    }
    
    // MARK: Private
    
    private class func defaultFrameNamePrefix() -> String {
        return "frame"
    }
}
