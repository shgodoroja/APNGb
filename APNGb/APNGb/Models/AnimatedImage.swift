//
//  AnimatedImage.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/26/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AnimatedImage: ImageOption {
    
    var path = String.empty
    
    func isPathValid() -> Bool {
        
        if path.characters.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    override func getValue() -> String {
        return path
    }
}
