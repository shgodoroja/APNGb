//
//  DragAndDropImageView.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/12/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

protocol DragAndDropImageViewDelegate {
    func didDropImage(withPath path: String)
}

final class DragAndDropImageView: NSImageView {
    
    var delegate: DragAndDropImageViewDelegate?
    
    private var imageTypeIsValid = false
    private let allowedFileTypes = ["png", "apng"]
    
    // MARK: - NSDraggingDestination
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        if isImageTypeAllowed(drag: sender) {
            imageTypeIsValid = true
            return .copy
        } else {
            imageTypeIsValid = false
            return []
        }
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
       
        if imageTypeIsValid {
            return .copy
        } else {
            return []
        }
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        if let pasteboard = sender.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? NSArray,
            let imagePath = pasteboard[0] as? String {
            delegate?.didDropImage(withPath: imagePath)
            return true
        }
        
        return false
    }
    
    // MARK: - Private
    
    func isImageTypeAllowed(drag: NSDraggingInfo) -> Bool {
        
        if let pasteboard = drag.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as? NSArray,
            let path = pasteboard[0] as? String {
            let url = NSURL(fileURLWithPath: path)
            
            if let fileExtension = url.pathExtension?.lowercased() {
                return allowedFileTypes.contains(fileExtension)
            }
        }
        
        return false
    }
}
