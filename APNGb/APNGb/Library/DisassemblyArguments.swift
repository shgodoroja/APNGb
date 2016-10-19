//
//  DisassemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class DisassemblyArguments: CommandArguments {
    
    var sourceImagePath = DisassemblyArguments.defaultArgumentValue()
    var destinationImageNamePrefix = DisassemblyArguments.defaultArgumentValue()
    
    func havePassedValidation() -> Bool {
        let arguments = commandArguments()
        
        for argument in arguments {
            
            if argument == DisassemblyArguments.defaultArgumentValue() {
                return false
            }
        }
        
        return true
    }
    
    func commandArguments() -> [String] {
        return [sourceImagePath, destinationImageNamePrefix]
    }
}
