//
//  NSTableCellViewExtension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/13/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension NSTableCellView {
    
    class func loadNib(withOwner owner: Any?) -> NSTableCellView? {
        
        var topLevelObjects: NSArray? = nil
        let nibName = String(describing: self)
        let cellViewNib = NSNib.init(nibNamed: NSNib.Name(rawValue: nibName),
                                     bundle: nil)
        cellViewNib?.instantiate(withOwner: owner,
                                 topLevelObjects: &topLevelObjects)
        
        if let topLevelObjects = topLevelObjects {
            
            for object in topLevelObjects {
                
                if let targetObject = object as? NSTableCellView {
                    return targetObject
                }
            }
        }
        
        return nil
    }
}
