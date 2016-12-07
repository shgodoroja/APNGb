//
//  NSViewControllerExtension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension NSViewController {
    
    /// Removes all child view controllers together with their views
    func removeChildViewControllers() {
        
        for childViewController in self.childViewControllers {
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
        }
        
    }
}
