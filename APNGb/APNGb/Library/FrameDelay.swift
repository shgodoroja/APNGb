//
//  FrameDelay.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class FrameDelay: NSObject, CommandArgumentable {
    
    var seconds = 1
    var frames = 10
    
    // MARK: - CommandArgumentable
    
    func validated() -> Bool {
        return true
    }
    
    func arguments() -> [String] {
        return ["\(seconds) \(frames)"]
    }
}
