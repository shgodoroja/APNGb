//
//  AssemblyFrameRowView.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/16/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyFrameRowView: NSTableRowView {

    override func drawSelection(in dirtyRect: NSRect) {
        
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 0, 0)
            NSColor(calibratedWhite: 0.65,
                    alpha: 1).setStroke()
            NSColor(calibratedWhite: 0.82,
                    alpha: 1).setFill()
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect,
                                                  xRadius: 0,
                                                  yRadius: 0)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
}
