//
//  SideBarItemGroup.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

protocol Clickable {
    func didClickOnItem(atIndex index: Int)
}

protocol SideBarItemGroupDelegate: Clickable {

}

class SideBarItemGroup: NSObject {
    
    var delegate: SideBarItemGroupDelegate?
    
    private var items: [NSButton]
    
    override init() {
        items = []
    }
    
    func addItem(item: NSButton) {
        items.append(item)
    }
    
    func setup() {
        
        for item in items {
            item.target = self
            item.action = #selector(didClickOn(item:))
        }
    }
    
    func setDefaultSelectedItem(atIndex index: Int) {
        
        if index < items.count {
            let item = items[index]
            item.state = NSOnState
        }
    }
    
    @objc
    private func didClickOn(item: NSButton) {
        let selectedItemIndex = items.index(of: item)
        self.delegate?.didClickOnItem(atIndex: selectedItemIndex!)
        
        for item in items {
            item.state = NSOffState
        }
        
        item.state = NSOnState
    }
}
