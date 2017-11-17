//
//  MainContainerViewLayout.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

protocol ViewLayout {
    
    func update(_ view: NSView,
                withIdentifier identifier: ViewControllerId,
                andSuperview: NSView)
}

class MainContainerViewLayout: ViewLayout {
    
    func update(_ view: NSView,
                withIdentifier identifier: ViewControllerId,
                andSuperview superview: NSView) {
        
        switch identifier {
            
        case .SideBar:
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: ViewSize.SideBar.width).isActive = true
        case .ChildContainer:
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        case .PreferencesPane:
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: ViewSize.Preferences.width).isActive = true
        default:
            assertionFailure("\(#function): View constraints weren't updated because case wasn't handled")
        }
    }
}
