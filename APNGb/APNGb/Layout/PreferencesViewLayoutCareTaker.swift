//
//  PreferencesViewLayoutCareTaker.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/10/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesViewLayoutCareTaker: ViewLayoutCareTaker {
    
    func updateLayoutOf(_ view: NSView,
                        withIdentifier identifier: ViewControllerId,
                        superview: NSView,
                        andSiblingView sibling: NSView?) {
        
        switch identifier {
            
        case .Preferences:
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
        default:
            assertionFailure("\(#function): View constraints weren't updated because case wasn't handled")
        }
    }
}
