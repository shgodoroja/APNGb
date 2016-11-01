//
//  DragAndDropView.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/12/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DragAndDropView: NSView {
    
    var delegate: DragAndDropImageDelegate?
    
    private var validator: DragAndDropValidator
    private let allowedFileTypes = ["png"]
    
    required init?(coder: NSCoder) {
        validator = DragAndDropValidator(withAllowedFileTypes: allowedFileTypes)
        super.init(coder: coder)
        self.register(forDraggedTypes: [NSFilenamesPboardType])
    }
    
    // MARK: - NSDraggingDestination
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return validator.draggingEntered(sender)
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return validator.draggingUpdated(sender)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let imagesPaths = validator.draggingResult(sender)
        delegate?.didDropImages(withPaths: imagesPaths)
        
        return true
    }
}
