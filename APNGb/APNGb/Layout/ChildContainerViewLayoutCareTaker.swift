//
//  ChildContainerViewLayoutCareTaker.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildContainerViewLayoutCareTaker: ViewLayoutCareTaker {
    
    func updateLayoutOf(_ view: NSView,
                        withIdentifier identifier: ViewControllerId,
                        superview: NSView,
                        andSiblingView sibling: NSView?) {
        
        switch identifier {
        case .Assembly,
             .Disassembly:
                view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                
                if let sibling = sibling {
                    view.bottomAnchor.constraint(equalTo: sibling.topAnchor).isActive = true
                }
            
        case .BottomToolbar:
                view.heightAnchor.constraint(equalToConstant: ViewSize.BottomToolbar.height).isActive = true
                view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        case .DropHint:
                view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                
                if let sibling = sibling {
                    view.bottomAnchor.constraint(equalTo: sibling.topAnchor).isActive = true
                }
            
        default:
            assertionFailure("\(#function): View constraints weren't updated because case wasn't handled")
        }
    }
}
