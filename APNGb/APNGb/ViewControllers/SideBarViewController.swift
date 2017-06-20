//
//  SideBarViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/6/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class SideBarViewController: NSViewController, ScenePresentable {

    var delegate: ScenePresentable?
    
    private var sideBarItemGroup: SideBarItemGroup?
    
    @IBOutlet private var assemblyItemButton: NSButton!
    @IBOutlet private var disassemblyItemButton: NSButton!
    @IBOutlet private var optimizeItemButton: NSButton!
    @IBOutlet private var convertItemButton: NSButton!
    
    // MARK: - Life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
        self.setupSideBar()
    }
    
    // MARK: - ScenePresentable

    func presentScene(withIdentifier identifier: MainScene) {
        delegate?.presentScene(withIdentifier: identifier)
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
        sideBarItemGroup?.addItem(item: optimizeItemButton)
        sideBarItemGroup?.addItem(item: convertItemButton)
        sideBarItemGroup?.selectItem(item: assemblyItemButton)
    }
}
