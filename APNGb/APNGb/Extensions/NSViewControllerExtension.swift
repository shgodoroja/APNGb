//
//  NSViewControllerExtension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension NSViewController {
    
    /// Removes all child view controllers together with associated views.
    func removeChildViewControllers() {
        
        for childViewController in self.childViewControllers {
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParentViewController()
        }
    }
    
    /// Removes all child view controllers together with associated views, ignoring
    /// view controllers from the parameter.
    /// - Parameter viewControllers: view controllers which won't be removed from 
    /// `childviewcontrollers` stack.
    func removeChildViewControllersExcept(viewControllers: [NSViewController]) {
        
        for childViewController in self.childViewControllers {
            
            if viewControllers.contains(childViewController) == false {
                
                childViewController.view.removeFromSuperview()
                childViewController.removeFromParentViewController()
            }
        }
    }
    
    /// Adds child view controller to `childviewcontrollers` stack and
    /// it's view to current view controller's associated view.
    /// - Parameter identifier: Storyboard identifier of the child view controller.
    /// - Returns: View controller identified by storyboard identifier or `nil` if
    /// no view controller was associated with that identifier.
    func showChildViewController(withIdentifier identifier: String) -> NSViewController? {
        let loadedController = storyboard?.instantiateController(withIdentifier: identifier)
        
        if loadedController is NSViewController {
            let childViewController = loadedController as! NSViewController
            self.addChildViewController(childViewController)
            childViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(childViewController.view)
            return childViewController
        } else {
            return nil
        }
    }
}
