//
//  MainContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/6/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum ChildViewControllerIdentifier: Int {
    case Assembly
    case Disassembly
}

struct StoryboardViewIdentifier {
    
    static let Assembly = "assembly.view"
    static let Disassembly = "disassembly.view"
    static let Status = "status.view"
}

struct MainContainerSubviewSize {
    
    static let SideBar = NSMakeSize(60, height)
    static let ChildContainer = NSMakeSize(500, height)
    
    private static let height: CGFloat = 500.0
}

class MainContainerViewController: NSSplitViewController, SideBarViewControllerDelegate {
    
    private var sideBarViewController: SideBarViewController?
    private var childContainerViewController: ChildContainerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initChildViewControllers()
    }
    
    private func initChildViewControllers() {
        for childViewController in self.childViewControllers {
            
            if childViewController is SideBarViewController {
                sideBarViewController = childViewController as? SideBarViewController
                sideBarViewController?.delegate = self
            } else if childViewController is ChildContainerViewController {
                childContainerViewController = childViewController as? ChildContainerViewController
            }
        }
    }
    
    // MARK: SideBarViewControllerDelegate
    
    func didClickOnItem(atIndex index: Int) {
        
        switch index  {
        case ChildViewControllerIdentifier.Assembly.rawValue:
            childContainerViewController?.showChildViewController(withIdentifier: StoryboardViewIdentifier.Assembly)
        case ChildViewControllerIdentifier.Disassembly.rawValue:
            childContainerViewController?.showChildViewController(withIdentifier: StoryboardViewIdentifier.Disassembly)
        default:
            NSLog("didClickOnItem: Unexpected case")
        }
    }
}
