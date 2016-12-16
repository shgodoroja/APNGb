//
//  AnimationFrame.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AnimationFrame {
    
    var delaySeconds = 1
    var delayFrames = 10
    var displayableFrameDelay: String {
        get {
            return "\(delaySeconds)/\(delayFrames)"
        }
    }
    
    private(set) var path: String
    private(set) var size: Int
    private(set) var name: String
    
    init(url: NSURL, size: Int) {
        self.size = size
        
        if let lastPathComponent = url.lastPathComponent {
            self.name = lastPathComponent
        } else {
            self.name = String.empty
        }
        
        if let urlAsPath = url.path {
            self.path = urlAsPath
        } else {
            self.path = String.empty
        }
    }
}
