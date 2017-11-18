//
//  ImageFile.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class ImageFile: ImageOption {
    
    @objc var delay = 100
    @objc var size: Int
    @objc var name = String.empty
    @objc var resource: NSImage
    
    private(set) var path = String.empty

    
    init(url: NSURL, size: Int) {
        self.size = size
        
        if let lastPathComponent = url.lastPathComponent {
            self.name = lastPathComponent
        }
        
        if let urlAsPath = url.path {
            self.path = urlAsPath
        }
        
        self.resource = NSImage(contentsOf: url as URL)!
    }
}
