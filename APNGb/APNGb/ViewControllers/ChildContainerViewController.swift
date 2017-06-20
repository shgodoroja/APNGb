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
    
    // MARK: - SceneContainerable
    
    func addChildViewControllerForScene(withIdentifier identifier: MainScene) {
        let viewLayoutCareTaker = ChildContainerViewLayoutCareTaker()
        
        self.removeChildViewControllers()
        let childViewControllerIdentifier = self.childViewControllerIdentifierForScene(withIdentifier: identifier)
        currentPresentedViewController = self.showChildViewController(withIdentifier: childViewControllerIdentifier.storyboardVersion())
        
        if let viewController = currentPresentedViewController as? PlayAnimationViewController {
            viewController.config = self.playAnimationViewControllerConfigForScene(withIndentifier: identifier)
        }
        
        if let view = currentPresentedViewController?.view {
            
            if let superview = view.superview {
                viewLayoutCareTaker.updateLayoutOf(view,
                                                   withIdentifier: childViewControllerIdentifier,
                                                   superview: superview,
                                                   andSiblingView: nil)
            }
        }
    }
    
    func childViewControllerIdentifierForScene(withIdentifier identifier: MainScene) -> ViewControllerId {
        
        switch identifier {
        case .AssemblyScene:
            return .FrameList
        case .DisassemblyScene,
             .OptimizeScene,
             .ConvertScene:
            return .PlayAnimation
        default:
            return .Unknown
        }
    }
    
    func playAnimationViewControllerConfigForScene(withIndentifier identifier: MainScene) -> PlayAnimationViewControllerConfig? {
        let config = PlayAnimationViewControllerConfig()
        
        switch identifier {
        case .DisassemblyScene,
             .OptimizeScene:
            config.allowedFileTypes = [FileExtension.apng, FileExtension.png]
            config.hintMessage = Resource.String.dropAnimatedPngHere
        case .ConvertScene:
            config.allowedFileTypes = [FileExtension.apng, FileExtension.png, FileExtension.gif]
            config.hintMessage = Resource.String.dropAnimatedImageHere
        default:
            return nil
        }
        
        return config
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
