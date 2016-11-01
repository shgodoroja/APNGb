//
//  DragAndDropValidator.swift
//  APNGb
//
//  Created by Stefan Godoroja on 11/2/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

struct DragAndDropValidator {
    
    var imageTypeIsValid = false
    var allowedFileTypes: [String] = []
    
    init(withAllowedFileTypes fileTypes: [String]) {
        self.allowedFileTypes = fileTypes
    }
    
    mutating func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        if isImageTypeAllowed(drag: sender) {
            imageTypeIsValid = true
            return .copy
        } else {
            imageTypeIsValid = false
            return []
        }
    }
    
    func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        if imageTypeIsValid {
            return .copy
        } else {
            return []
        }
    }
    
    func draggingResult(_ sender: NSDraggingInfo) -> [String] {
        
        if let droppedImagesPaths = sender.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? Array<String> {
            var paths: [String] = []
            
            for imagePath in droppedImagesPaths {
                let imageUrl = NSURL(fileURLWithPath: imagePath)
                let fileExtension = imageUrl.lastPathComponent?.fileExtension()
                
                if let fileExtension = fileExtension {
                    
                    if allowedFileTypes.contains(fileExtension) {
                        paths.append(imagePath)
                    }
                }
            }
            
            return paths
        }
        
        return []
    }
    
    func isImageTypeAllowed(drag: NSDraggingInfo) -> Bool {
        
        if let droppedImagesPaths = drag.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? Array<String> {
            let url = NSURL(fileURLWithPath: droppedImagesPaths[0])
            
            if let fileExtension = url.pathExtension?.lowercased() {
                return allowedFileTypes.contains(fileExtension)
            }
        }
        
        return false
    }
}
