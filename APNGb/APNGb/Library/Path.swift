//
//  Path.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Path: NSObject, CommandArgumentable {
    
    var outputFileNamePrefix = "apng-frame"
    var animatedImagePath = String.empty
    
    // MARK: - CommandArgumentable
    
    func validated() -> Bool {
        
        for argument in self.arguments() {
            
            if argument == String.empty {
                return false
            }
        }
        
        return true
    }
    
    func arguments() -> [String] {
        return [animatedImagePath, outputFileNamePrefix]
    }
}
