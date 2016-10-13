//
//  MainTabViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/17/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class MainTabViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        disableViewResizing()
    }
    
    private func disableViewResizing() {
        self.preferredContentSize = self.view.frame.size
    }
}

