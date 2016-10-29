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
    static let slash = "/"
    static let space = " "
    static let kilobyteAbbreviation = "KB"
    
    func fileName() -> String {
        
        if let fileNameWithoutExtension = NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent {
            return fileNameWithoutExtension
        } else {
            return String.empty
        }
    }
    
    func fileExtension() -> String {
        
        if let fileExtension = NSURL(fileURLWithPath: self).pathExtension {
            return fileExtension
        } else {
            return String.empty
        }
    }
}
