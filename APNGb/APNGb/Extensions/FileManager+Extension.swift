//
//  FileManager+Extension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension FileManager {
    
    /** 
        Returns size of file in KBs
     */
    func sizeOfFile(atPath path: String) -> Int {
        do {
            let fileAttributes = try self.attributesOfItem(atPath: path) as NSDictionary
            let fileSizeInKB = fileAttributes.fileSize() / UInt64(1000)
            return Int(fileSizeInKB)
        } catch let error {
            NSLog("\(#function): \(error)")
            return 0
        }
    }
}
