//
//  FrameDelay.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum FrameDelayCategory {
    case All, Selected
}

final class FrameDelay: NSObject, CommandArgumentable {
    
    var category: FrameDelayCategory
    var enabled: Bool
    var seconds = 1
    var frames = 10
    
    init(withCategory category: FrameDelayCategory = .All, andState state: Bool = true) {
        self.category = category
        self.enabled = state
    }
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(FrameDelay.seconds) {
            seconds = 1
        }
        
        if key == #keyPath(FrameDelay.frames) {
            frames = 10
        }
    }
    
    // MARK: - CommandArgumentable
    
    func havePassedValidation() -> Bool {
        return true
    }
    
    func commandArguments() -> ([String], Any?) {
        var arguments: [String] = []
        
        if enabled {
            arguments.append("\(seconds) \(frames)")
        }
        
        return (arguments, nil)
    }
}
