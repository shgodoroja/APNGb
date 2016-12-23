//
//  ChildContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildContainerViewController: NSViewController {
    
    var assemblyArguments: AssemblyArguments?
    var disassemblyArguments: DisassemblyArguments?
    
    private var viewLayoutCareTaker: ChildContainerViewLayoutCareTaker
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = ChildContainerViewLayoutCareTaker()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addChildViewController(withIndentifier identifier: ViewControllerId) {
        self.removeChildViewControllers()
        let childViewController = self.showChildViewController(withIdentifier: identifier.storyboardVersion())
       
        if let viewController = childViewController as? AssemblyViewController {
            viewController.assemblyArguments = assemblyArguments
        } else if let viewController = childViewController as? DisassemblyViewController {
            viewController.disassemblyArguments = disassemblyArguments
        }
        
        if let view = childViewController?.view {
            
            if let superview = view.superview {
                viewLayoutCareTaker.updateLayoutOf(view,
                                                   withIdentifier: identifier,
                                                   superview: superview,
                                                   andSiblingView: nil)
            }
        }
    }
}
