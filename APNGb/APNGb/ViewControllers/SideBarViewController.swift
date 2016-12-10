//
//  SideBarViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/6/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

protocol SideBarViewControllerDelegate: Clickable {
    
}

class SideBarViewController: NSViewController, SideBarItemGroupDelegate {

    var delegate: SideBarViewControllerDelegate?
    
    private var sideBarItemGroup: SideBarItemGroup?
    
    @IBOutlet private var assemblyItemButton: NSButton!
    @IBOutlet private var disassemblyItemButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setupSideBar()
    }

    private func applyStyle() {
        self.view.backgroundColor = NSColor(colorLiteralRed: 233/255, green: 70/255, blue: 43/255, alpha: 1.0)
    }
    
    private func setupSideBar() {
        sideBarItemGroup = SideBarItemGroup()
        sideBarItemGroup?.delegate = self
        sideBarItemGroup?.addItem(item: assemblyItemButton)
        sideBarItemGroup?.addItem(item: disassemblyItemButton)
        sideBarItemGroup?.setDefaultSelectedItem(atIndex: 0)
        sideBarItemGroup?.setup()
    }
    
    // MARK:
    
    func didClickOnItem(atIndex index: Int) {
        delegate?.didClickOnItem(atIndex: index)
    }
}
