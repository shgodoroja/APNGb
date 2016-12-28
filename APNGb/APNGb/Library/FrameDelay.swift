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

enum NotificationIdentifier: String {
    case didChangeAllFramesDelay = "didChangeAllFramesDelay"
    case didChangeSelectedFramesDelay = "didChangeSelectedFramesDelay"
}

final class FrameDelay: NSObject, CommandArgumentable {
    
    var category: FrameDelayCategory
    var enabled: Bool
    var seconds = 1 {
        
        didSet {
            self.notifyObservers()
        }
    }
    var frames = 10 {
        
        didSet {
            self.notifyObservers()
        }
    }
    
    init(withCategory category: FrameDelayCategory = .All, andState state: Bool = true) {
        self.category = category
        
        if category == .Selected {
            self.enabled = false
        } else {
            self.enabled = state
        }
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
    
    // MARK: - Private
    
    private func notifyObservers() {
        
        if self.category == .Selected {
            NotificationCenter.default.post(name: NSNotification.Name(NotificationIdentifier.didChangeSelectedFramesDelay.rawValue),
                                            object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(NotificationIdentifier.didChangeAllFramesDelay.rawValue),
                                            object: nil)
        }
    }
    
}
