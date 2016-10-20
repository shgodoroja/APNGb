//
//  String+Extension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/20/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension String {
    
    static let empty = ""
    
    func fileExtension() -> String {
        
        if let fileExtension = NSURL(fileURLWithPath: self).pathExtension {
            return fileExtension
        } else {
            return String.empty
        }
    }
}
