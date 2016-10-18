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

class FrameDelay {
    
    var category: FrameDelayCategory?
    var seconds = 1
    var frames = 10
}
