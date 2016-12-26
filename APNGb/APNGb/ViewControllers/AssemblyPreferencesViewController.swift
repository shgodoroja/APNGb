//
//  AssemblyPreferencesViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyPreferencesViewController: NSViewController {
    
    dynamic var assemblyArguments: AssemblyArguments?
    dynamic var stripPopUpDataSource: StripPopUpDataSource
    
    required init?(coder: NSCoder) {
        stripPopUpDataSource = StripPopUpDataSource()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.Color.preferencesPane
    }
}
