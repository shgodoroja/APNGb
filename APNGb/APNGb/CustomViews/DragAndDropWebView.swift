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
            let html = "<html><head><style type='text/css'>html,body {margin: 0;padding: 0;width: 100%;height: 100%;}html {display: table;}body {display: table-cell;vertical-align: middle;text-align: center;-webkit-text-size-adjust: none;}</style></head><body><img src=\"file://\(imagePath)\"></body></html>​"
            mainFrame.loadHTMLString(html, baseURL: nil)
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
