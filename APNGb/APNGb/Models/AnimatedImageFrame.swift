//
//  AnimatedImageFrame.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AnimatedImageFrame: ImageOption {
    
    var delaySeconds = 1
    var delayFrames = 10
    
    var displayableDelay: String {
        
        get {
            return Resource.String.delay + String.colon + String.space + String(delaySeconds) + String.slash + String(delayFrames)
        }
    }
    
    var displayableSize: String {
        
        get {
            return Resource.String.size + String.colon +  String.space + String(size) + String.space + String.kilobyteAbbreviation
        }
    }
    
    private(set) var path = String.empty
    private(set) var size: Int
    private(set) var name = String.empty
    
    init(url: NSURL, size: Int) {
        self.size = size
        
        if let lastPathComponent = url.lastPathComponent {
            self.name = lastPathComponent
        }
        
        if let urlAsPath = url.path {
            self.path = urlAsPath
        }
    }
}
