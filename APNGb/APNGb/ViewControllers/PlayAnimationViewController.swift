//
//  PlayAnimationViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa
import WebKit

protocol Parameterizable {
    func params() -> [ParameterProtocol]
}

final class PlayAnimationViewControllerConfig {
    
    var hintMessage = String.empty
    var allowedFileTypes = [String]()
}

final class PlayAnimationViewController: NSViewController, DragAndDropDelegate, Parameterizable {
    
    var config: PlayAnimationViewControllerConfig? {
        
        didSet {
            self.updateHintMessage()
            self.updateAcceptedFileExtensions()
        }
    }
    
    private var animatedImage: AnimatedImage
    private var dropHintViewController: DropHintViewController?
    
    @IBOutlet private var destinationWebView: DragAndDropWebView!
    
    required init?(coder: NSCoder) {
        animatedImage = AnimatedImage()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDropHintViewController()
        self.configureWebView()
    }
    
    // MARK: - Parametrable
    
    func params() -> [ParameterProtocol] {
        return [animatedImage]
    }
    
    // MARK: - DragAndDropImageViewDelegate
    
    func didDropFiles(withPaths paths: [String]) {
        animatedImage.path = paths[0]
        self.updateUI()
        
        let animatedImageExtension = animatedImage.path.fileExtension()
        NotificationCenter.default.post(name: NSNotification.Name(NotificationIdentifier.animatedImageDropped.rawValue),
                                        object: animatedImageExtension)
    }
    
    // MARK: - Private
    
    private func configureWebView() {
        destinationWebView.delegate = self
        destinationWebView.drawsBackground = false
        destinationWebView.mainFrame.frameView.allowsScrolling = false
    }
    
    private func updateUI() {
        
        if animatedImage.isPathValid() {
            dropHintViewController?.view.isHidden = true
            destinationWebView.loadImage(path: animatedImage.path)
        } else {
            dropHintViewController?.view.isHidden = false
        }
    }
    
    // MARK: - Child view controllers presentation
    
    private func addDropHintViewController() {
        let viewLayoutCareTaker = ChildViewLayoutCareTaker()
        
        if dropHintViewController == nil {
            dropHintViewController = showChildViewController(withIdentifier: ViewControllerId.DropHint.storyboardVersion()) as! DropHintViewController?
            
            if let view = dropHintViewController?.view {
                
                if let superview = view.superview {
                    viewLayoutCareTaker.updateLayoutOf(view,
                                                       withIdentifier: .DropHint,
                                                       superview: superview,
                                                       andSiblingView: nil)
                }
            }
        }
    }
    
    private func updateHintMessage() {
        
        if let hintMessage = config?.hintMessage {
            dropHintViewController?.hintMessage = hintMessage
        }
    }
    
    private func updateAcceptedFileExtensions() {
        
        if let allowedFileTypes = config?.allowedFileTypes {
            destinationWebView.allowedFileTypes = allowedFileTypes
        }
    }
}
