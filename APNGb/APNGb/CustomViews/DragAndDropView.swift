//
//  DragAndDropView.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/12/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

protocol DragAndDropDelegate {
    func didDropFiles(withPaths paths: [String])
}

final class DragAndDropView: NSView {
    
    var delegate: DragAndDropDelegate?
    var allowedFileTypes = [String]() {
        
        didSet {
            validator.allowedFileTypes = allowedFileTypes
        }
    }

    private var validator: DragAndDropValidator
    
    required init?(coder: NSCoder) {
        validator = DragAndDropValidator()
        super.init(coder: coder)        
        self.registerForDraggedTypes([validator.NSFilenamesPboardType])
    }
    
    // MARK: - NSDraggingDestination
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return validator.draggingEntered(sender)
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return validator.draggingUpdated(sender)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let paths = validator.draggingResult(sender)
        delegate?.didDropFiles(withPaths: paths)
        
        return true
    }
}
