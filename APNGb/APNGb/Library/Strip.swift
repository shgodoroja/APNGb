//
//  Strip.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/24/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Strip: NSObject, CommandArgumentable {

    var orientation = String.empty
    var numberOfFrames = 0
    
    // MARK: - CommandArgumentable
    
    func validated() -> Bool {
        
        if numberOfFrames == 0 {
            return false
        }
        
        if orientation == String.empty {
            return false
        }
        
        return true
    }
    
    func arguments() -> [String] {
        return [orientation + "\(numberOfFrames)"]
    }
}
