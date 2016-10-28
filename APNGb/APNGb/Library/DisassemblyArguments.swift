//
//  DisassemblyArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyArguments: CommandArguments {
    
    var sourceImagePath = DisassemblyArguments.defaultArgumentValue()
    var destinationImagesPath = DisassemblyArguments.defaultArgumentValue() {
        
        didSet {
            
            if destinationImagesPath.characters.count > 0 {
                destinationImagesPath.append(String.slash)
            }
        }
    }
    
    var destinationImagesNamePrefix = DisassemblyArguments.defaultDestinationImagesNamePrefix()
    
    class func defaultDestinationImagesNamePrefix() -> String {
        return "frame"
    }
    
    func destinationImagesFullPath() -> String {
        return destinationImagesPath + destinationImagesNamePrefix
    }
    
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
        return [sourceImagePath, destinationImagesPath, destinationImagesNamePrefix]
    }
}
