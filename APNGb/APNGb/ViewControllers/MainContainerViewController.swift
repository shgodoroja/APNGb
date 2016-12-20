//
//  MainContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/6/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class MainContainerViewController: NSSplitViewController, Clickable  {
    
    private var assemblyArguments = AssemblyArguments()
    private var disassemblyArguments = DisassemblyArguments()
    
    private var viewLayoutCareTaker: MainContainerViewLayoutCareTaker
    private var sideBarViewController: SideBarViewController?
    private var childContainerViewController: ChildContainerViewController?
    private var preferencesContainerViewController: PreferencesContainerViewController?
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = MainContainerViewLayoutCareTaker()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildViewControllers()
        self.presentInitialChildViewControllers()
    }
    
    // MARK: SideBarViewControllerDelegate
    
    func didClickOnItem(atIndex index: Int) {
        childContainerViewController?.addChildViewController(withIndentifier: ViewControllerId(fromRawValue: index))
        preferencesContainerViewController?.addChildViewController(withIndentifier: ViewControllerId(fromRawValue: index))
    }
    
    // MARK: Private
    
    private func presentInitialChildViewControllers() {
        didClickOnItem(atIndex: 0)
    }
    
    private func setupChildViewControllers() {
        
        for childViewController in self.childViewControllers {
            
            // Find SideBar VC
            if childViewController is SideBarViewController {
                sideBarViewController = childViewController as? SideBarViewController
                
                if let view = sideBarViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayoutCareTaker.updateLayoutOf(view,
                                                           withIdentifier: ViewControllerId.SideBar,
                                                           superview: superview,
                                                           andSiblingView: nil)
                    }
                }
                
                sideBarViewController?.delegate = self
            }
            // Find Child Container VC
            else if childViewController is ChildContainerViewController {
                childContainerViewController = childViewController as? ChildContainerViewController
                childContainerViewController?.assemblyArguments = assemblyArguments
                childContainerViewController?.disassemblyArguments = disassemblyArguments
                
                if let view = childContainerViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayoutCareTaker.updateLayoutOf(view,
                                                           withIdentifier: ViewControllerId.ChildContainer,
                                                           superview: superview,
                                                           andSiblingView: sideBarViewController?.view)
                    }
                }
                
            }
            // Find Preferences VC
            else if childViewController is PreferencesContainerViewController {
                preferencesContainerViewController = childViewController as? PreferencesContainerViewController
                preferencesContainerViewController?.assemblyArguments = assemblyArguments
                preferencesContainerViewController?.disassemblyArguments = disassemblyArguments
                
                if let view = preferencesContainerViewController?.view {
                    
                    if let superview = view.superview {
                        viewLayoutCareTaker.updateLayoutOf(view,
                                                           withIdentifier: ViewControllerId.Preferences,
                                                           superview: superview,
                                                           andSiblingView: childContainerViewController?.view)
                    }
                }
            }
        }
    }
}
