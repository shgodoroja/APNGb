//
//  ChildContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildContainerViewController: NSViewController {
    
    private var viewLayoutCareTaker: ChildContainerViewLayoutCareTaker
    private var bottomToolbarViewController: BottomToolbarViewController?
    private var dropHintViewController: DropHintViewController?
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = ChildContainerViewLayoutCareTaker()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomToolbarViewController = showChildViewController(withIdentifier: ViewControllerId.BottomToolbar.storyboardVersion()) as! BottomToolbarViewController?
        
        if let view = bottomToolbarViewController?.view {
            
            if let superview = view.superview {
                viewLayoutCareTaker.updateLayoutOf(view,
                                                   withIdentifier: ViewControllerId.BottomToolbar,
                                                   superview: superview,
                                                   andSiblingView: nil)
            }
        }
        
        dropHintViewController = showChildViewController(withIdentifier: ViewControllerId.DropHint.storyboardVersion()) as! DropHintViewController?
        
        if let view = dropHintViewController?.view {
            
            if let superview = view.superview {
                viewLayoutCareTaker.updateLayoutOf(view,
                                                   withIdentifier: ViewControllerId.DropHint,
                                                   superview: superview,
                                                   andSiblingView: bottomToolbarViewController?.view)
            }
        }
    }
    
    func addChildViewController(withIndentifier identifier: ViewControllerId) {
        self.removeChildViewControllersExcept(viewControllers: [bottomToolbarViewController!, dropHintViewController!])
        
        switch identifier  {
            
        case ViewControllerId.Assembly:
            let assemblyViewController = self.showChildViewController(withIdentifier: ViewControllerId.Assembly.storyboardVersion())
            
            if let view = assemblyViewController?.view {
                
                if let superview = view.superview {
                    viewLayoutCareTaker.updateLayoutOf(view,
                                                       withIdentifier: ViewControllerId.Assembly,
                                                       superview: superview,
                                                       andSiblingView: bottomToolbarViewController?.view)
                }
            }
            
            dropHintViewController?.hintMessage = self.hintMessageForViewController(withIdentifier: ViewControllerId.Assembly)
            
        case ViewControllerId.Disassembly:
            let disassemblyViewController = self.showChildViewController(withIdentifier: ViewControllerId.Disassembly.storyboardVersion())
            
            if let view = disassemblyViewController?.view {
                
                if let superview = view.superview {
                    viewLayoutCareTaker.updateLayoutOf(view,
                                                       withIdentifier: ViewControllerId.Disassembly,
                                                       superview: superview,
                                                       andSiblingView: bottomToolbarViewController?.view)
                }
            }
            
            dropHintViewController?.hintMessage = self.hintMessageForViewController(withIdentifier: ViewControllerId.Disassembly)

        default:
            NSLog("\(#function): Unexpected case")
        }
    }
    
    // MARK: Private
    
    private func hintMessageForViewController(withIdentifier identifier: ViewControllerId) -> String {
        
        switch identifier {
        case .Assembly:
            return "Drop frames here"
        case .Disassembly:
            return "Drop animated image here"
        default:
            return String.empty
        }
    }
    
}
