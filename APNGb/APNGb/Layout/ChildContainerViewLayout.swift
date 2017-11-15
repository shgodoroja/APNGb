//
//  ChildContainerViewLayout.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildContainerViewLayout: ViewLayout {
    
    let marginOffset: CGFloat = 5.0
    
    func update(_ view: NSView,
                withIdentifier identifier: ViewControllerId,
                superview: NSView,
                andSiblingView sibling: NSView?) {
        
        switch identifier {
        case .ImageList,
             .PreviewImage:
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: marginOffset).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: marginOffset).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -marginOffset).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -marginOffset).isActive = true
        default:
            assertionFailure("\(#function): View constraints weren't updated because case wasn't handled")
        }
    }
}
