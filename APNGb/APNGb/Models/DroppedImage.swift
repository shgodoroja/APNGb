//
//  DroppedImage.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DroppedImage {
    
    var path: String
    var size: Int
    var displayableFrameDelay: String
    private(set) var name: String
    
    init(url: NSURL, size: Int) {
        self.size = size
        self.displayableFrameDelay = DroppedImage.defaultDisplayableFrameDelay()
        
        if let lastPathComponent = url.lastPathComponent {
            self.name = lastPathComponent
        } else {
            self.name = ""
        }
        
        if let urlAsPath = url.path {
            self.path = urlAsPath
        } else {
            self.path = ""
        }
    }
    
    private static func defaultDisplayableFrameDelay() -> String {
        return "1/10"
    }
}
