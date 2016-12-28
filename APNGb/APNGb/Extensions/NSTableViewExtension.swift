//
//  NSTableViewExtension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/28/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension NSTableView {
    
    func reloadDataKeepingSelection() {
        let selectedRowIndexes = self.selectedRowIndexes
        self.reloadData()
        self.selectRowIndexes(selectedRowIndexes, byExtendingSelection: true)
    }
}
