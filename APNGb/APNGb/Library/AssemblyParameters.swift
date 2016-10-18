//
//  AssemblyParameters.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class AssemblyParameters {

    var playback: Playback
    var optimization: Optimization
    var compression: Compression
    var allFramesDelay: FrameDelay
    var selectedFramesDelay: FrameDelay
    
    init() {
        playback = Playback()
        optimization = Optimization()
        compression = Compression()
        allFramesDelay = FrameDelay()
        selectedFramesDelay = FrameDelay()
    }
}
