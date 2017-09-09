//
//  Background.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/17/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Background: NSObject, CommandArgumentable {
    
    var transparency: Int = 0
    var color = String.empty
    
    // MARK: - CommandArgumentable
    
    func validated() -> Bool {
        let arguments = self.arguments()
        
        for argument in arguments {
            
            if argument == String.empty {
                return false
            }
        }
        
        return true
    }
    
    func arguments() -> [String] {
        let arguments = [String]()
        
        return arguments
    }
}
