//
//  Strip.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/24/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Strip: NSObject, CommandArgumentable  {

    var orientation = StripOrientation.none.rawValue
    var numberOfFrames = 0
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(Strip.numberOfFrames) {
            numberOfFrames = 0
        }
    }
    
    // MARK: - CommandArgumentable
    
    func havePassedValidation() -> Bool {
        
        if numberOfFrames == 0 {
            return false
        }
        
        if orientation == StripOrientation.none.rawValue {
            return false
        }
        
        return true
    }
    
    func commandArguments() -> ([String], Any?) {
        var arguments = [String]()
        arguments.append(StripOrientation.argumentValue(for: orientation) + "\(numberOfFrames)")

        return (arguments, nil)
    }
}
