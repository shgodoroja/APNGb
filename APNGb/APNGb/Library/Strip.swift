//
//  Strip.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/24/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum StripOrientation  {
    case vertical
    case horizontal
    case none
}

final class Strip: NSObject, CommandArgumentable  {
    
    var orientation = StripOrientation.none
    var numberOfFrames = 0
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(Strip.numberOfFrames) {
            
        }
    }
    
    // MARK: - CommandArgumentable
    
    func havePassedValidation() -> Bool {
        
        if numberOfFrames == 0 {
            return false
        }
        
        if orientation == .none {
            return false
        }
        
        return true
    }
    
    func commandArguments() -> ([String], Any?) {
        var arguments: [String] = []
        
        switch orientation {
        case .horizontal:
            arguments.append(Argument.horizontalStrip + "\(numberOfFrames)")
        case .vertical:
            arguments.append(Argument.verticalStrip + "\(numberOfFrames)")
        default:
            debugPrint("\(#function): unhandled case")
        }
        
        return (arguments, nil)
    }
}
