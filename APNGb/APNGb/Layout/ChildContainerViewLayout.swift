//
//  ChildContainerViewLayout.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ChildContainerViewLayout: ViewLayout {
    
    func update(_ view: NSView,
                withIdentifier identifier: ViewControllerId,
                andSuperview superview: NSView) {
        
        switch identifier {
        case .ImageList,
             .PreviewImage:
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        default:
            assertionFailure("\(#function): View constraints weren't updated because case wasn't handled")
        }
    }
}
