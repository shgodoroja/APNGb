//
//  SideBarViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/6/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class SideBarViewController: NSViewController, Clickable {

    var delegate: Clickable?
    
    private var sideBarItemGroup: SideBarItemGroup?
    
    @IBOutlet private var assemblyItemButton: NSButton!
    @IBOutlet private var disassemblyItemButton: NSButton!
    
    // MARK: - ViewController life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setupSideBar()
    }
    
    // MARK: - Clickable
    
    func didClickOnItem(atIndex index: Int) {
        delegate?.didClickOnItem(atIndex: index)
    }
    
    // MARK: - Private
    
    private func applyStyle() {
        self.view.backgroundColor = Theme.Color.sidebarBackground
    }
    
    private func setupSideBar() {
        sideBarItemGroup = SideBarItemGroup()
        sideBarItemGroup?.delegate = self
        sideBarItemGroup?.addItem(item: assemblyItemButton)
        sideBarItemGroup?.addItem(item: disassemblyItemButton)
        sideBarItemGroup?.setDefaultSelectedItem(atIndex: 0)
        sideBarItemGroup?.setup()
    }
}
