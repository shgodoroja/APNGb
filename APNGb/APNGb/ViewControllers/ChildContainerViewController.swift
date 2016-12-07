//
//  ChildContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildContainerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(500, 500)
    }
    
    func showChildViewController(withIdentifier identifier: String) {
        let loadedController = storyboard?.instantiateController(withIdentifier: identifier)
        
        if loadedController is NSViewController {
            let childViewController = loadedController as! NSViewController
            
            self.removeChildViewControllers()
            childViewController.view.frame = self.view.frame
            self.addChildViewController(childViewController)
            self.view.addSubview(childViewController.view)
        }
    }
}
