//
//  AssemblyViewLayoutCareTaker.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/15/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildViewLayoutCareTaker: ViewLayoutCareTaker {
    
    func updateLayoutOf(_ view: NSView, withIdentifier identifier: ViewControllerId, superview: NSView, andSiblingView sibling: NSView?) {
        
        switch identifier {
            
        case .DropHint:
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        default:
            assertionFailure("\(#function): View constraints weren't updated because case wasn't handled")
        }
    }
}
