//
//  FrameListTableViewDataSource.swift
//  APNGb
//
//  Created by Stefan Godoroja on 1/12/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class FrameListTableViewDataSource: NSObject, NSTableViewDataSource  {
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        
        if let reordableTableView = tableView as? ReordableTableView {
            return reordableTableView.writeRowsWith(rowIndexes: rowIndexes,
                                                    to: pboard)
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        
        if let reordableTableView = tableView as? ReordableTableView {
            return reordableTableView.validateDrop(validateDrop: info,
                                                   proposedRow: row,
                                                   proposedDropOperation: dropOperation)
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        
        if let reordableTableView = tableView as? ReordableTableView {
            return reordableTableView.acceptDrop(info: info,
                                                 forTableView: tableView,
                                                 row: row,
                                                 dropOperation: dropOperation)
        } else {
            return false
        }
    }
}
