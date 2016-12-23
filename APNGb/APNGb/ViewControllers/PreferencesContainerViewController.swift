//
//  PreferencesContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class PreferencesContainerViewController: NSViewController {
    
    var assemblyArguments: AssemblyArguments?
    var disassemblyArguments: DisassemblyArguments?
    
    private var viewLayoutCareTaker: PreferencesViewLayoutCareTaker
    private var assemblyPreferencesViewController: AssemblyPreferencesViewController?
    private var disassemblyPreferencesViewController: DisassemblyPreferencesViewController?
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = PreferencesViewLayoutCareTaker()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addChildViewController(withIndentifier identifier: ViewControllerId) {
        self.removeChildViewControllers()
        
        switch identifier  {
        case ViewControllerId.Assembly:
            assemblyPreferencesViewController = self.showChildViewController(withIdentifier: ViewControllerId.AssemblyPreferences.storyboardVersion()) as! AssemblyPreferencesViewController?
            assemblyPreferencesViewController?.assemblyArguments = assemblyArguments
            
            if let view = assemblyPreferencesViewController?.view {
                
                if let superview = view.superview {
                    viewLayoutCareTaker.updateLayoutOf(view,
                                                       withIdentifier: ViewControllerId.Preferences,
                                                       superview: superview,
                                                       andSiblingView: nil)
                }
            }
            
        case ViewControllerId.Disassembly:
            disassemblyPreferencesViewController = self.showChildViewController(withIdentifier: ViewControllerId.DisassemblyPreferences.storyboardVersion()) as! DisassemblyPreferencesViewController?
            disassemblyPreferencesViewController?.disassemblyArguments = disassemblyArguments
            
            if let view = disassemblyPreferencesViewController?.view {
                
                if let superview = view.superview {
                    
                    viewLayoutCareTaker.updateLayoutOf(view,
                                                       withIdentifier: ViewControllerId.Preferences,
                                                       superview: superview,
                                                       andSiblingView: nil)
                }
            }
            
        default:
            NSLog("\(#function): Unexpected case")
        }
    }
}
