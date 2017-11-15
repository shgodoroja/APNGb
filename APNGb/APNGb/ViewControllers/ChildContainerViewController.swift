//
//  ChildContainerViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum NotificationIdentifier: String {
    case didChangeFramesDelay = "NotificationIdentifier.didChangeFramesDelay"
    case enableDelayFields = "NotificationIdentifier.enableDelayFields"
    case animatedImageDropped = "NotificationIdentifier.animatedImageDropped"
}

class ChildContainerViewController: NSViewController, SceneContainerable, Parameterizable {
    
    private var currentPresentedViewController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private
    
    func updateHint(forViewController viewController: NSViewController?, withScene scene: Scene) {
        
        if let viewController = viewController as? ImageListViewController {
            
            switch scene {
            case .Assembly:
                viewController.tableHint = Resource.String.Hint.dropPng
            case .Disassembly, .Optimize:
                viewController.tableHint = Resource.String.Hint.dropAnimatedPng
            case .Convert:
                viewController.tableHint = Resource.String.Hint.dropAnimatedImage
            default:
                viewController.tableHint = String.empty
            }
        }
    }
    
    // MARK: - SceneContainerable
    
    func addChildViewController(forScene scene: Scene) {
        
        self.removeChildViewControllers()
        let childViewControllerIdentifier = ViewControllerId.ImageList
        currentPresentedViewController = self.showChildViewController(withIdentifier: childViewControllerIdentifier.storyboardVersion())
        updateHint(forViewController: currentPresentedViewController,
                   withScene: scene)
        
        if let view = currentPresentedViewController?.view {
            
            if let superview = view.superview {
                let viewLayout = ChildContainerViewLayout()
                viewLayout.update(view,
                                  withIdentifier: childViewControllerIdentifier,
                                  superview: superview,
                                  andSiblingView: nil)
            }
        }
    }
    
    // MARK: - Parameterizable
    
    func params() -> [ParameterProtocol] {
        
        if let presentedViewController = currentPresentedViewController as? Parameterizable {
            return presentedViewController.params()
        } else {
            return []
        }
    }
}
