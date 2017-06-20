//
//  FrameListTableViewDelegate.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/12/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class FrameListTableViewDelegate: NSObject, NSTableViewDelegate, NSTableViewDataSource {
    
    var onSelectionChange: VoidHandler?
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if let onSelectionChange = onSelectionChange {
            onSelectionChange!()
        }
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return FrameRowView()
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return FrameRowView.height()
    }
}
