//
//  FileManagerExtension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

struct FileExtension {
    
    static let txt = "txt"
    static let png = "png"
    static let apng = "apng"
    static let gif = "gif"
}

extension FileManager {
    
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
    
    func writeToFile(content: String, filePath: String) {
        
        if let fileHandle = FileHandle(forWritingAtPath: filePath) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(content.data(using: String.Encoding.utf8)!)
        } else {
            
            do {
                try content.write(toFile: filePath,
                                  atomically: true,
                                  encoding: String.Encoding.utf8)
            } catch let error {
                NSLog("\(#function): \(error)")
            }
        }
    }
    
    func removeItemIfExists(atPath path: String) -> Bool {
        
        if fileExists(atPath: path) {
            
            do {
                try removeItem(atPath: path)
            } catch let error {
                NSLog("\(#function): \(error)")
                return false
            }
            
            return true
        }
        
        return true
    }
}
