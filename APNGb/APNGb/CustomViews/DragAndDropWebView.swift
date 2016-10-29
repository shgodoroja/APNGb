//
//  DragAndDropWebView.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/27/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import WebKit

protocol DragAndDropImageDelegate {
    func didDropImage(withPath path: String)
}

final class DragAndDropWebView: WebView {
    
    var delegate: DragAndDropImageDelegate?
    
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
            let imageHTML = "<!DOCTYPE html> <head> <style type=\"text/css\"> html { margin:0; padding:0; } body {margin: 0; padding:0;} img {position:absolute; top:0; bottom:0; left:0; right:0; margin:auto; max-width:100%; max-height: 100%;} </style> </head> <body id=\"page\"> <img src=\"file://\(imagePath)\"> </body> </html>​"
            mainFrame.loadHTMLString(imageHTML, baseURL: nil)
            delegate?.didDropImage(withPath: imagePath)
            return true
        } else {
            return false
        }
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
