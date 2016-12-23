//
//  DisassemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa
import WebKit

final class DisassemblyViewController: NSViewController, DragAndDropDelegate {
    
    var disassemblyArguments: DisassemblyArguments?
    
    private var dropHintViewController: DropHintViewController?
    private var viewLayoutCareTaker: ChildViewLayoutCareTaker
    
    @IBOutlet private var destinationWebView: DragAndDropWebView!
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = ChildViewLayoutCareTaker()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDropHintViewController()
        self.configureWebView()
    }
    
    // MARK: - DragAndDropImageViewDelegate
    
    func didDropFiles(withPaths paths: [String]) {
        dropHintViewController?.view.isHidden = true
        disassemblyArguments?.sourceAnimationImagePath = paths[0]
    }
    
    // MARK: - Private
    
    private func configureWebView() {
        destinationWebView.delegate = self
        destinationWebView.drawsBackground = false
        destinationWebView.mainFrame.frameView.allowsScrolling = false
    }
    
    // MARK: - Child view controllers presentation
    
    private func addDropHintViewController() {
        
        if dropHintViewController == nil {
            dropHintViewController = showChildViewController(withIdentifier: ViewControllerId.DropHint.storyboardVersion()) as! DropHintViewController?
            
            if let view = dropHintViewController?.view {
                
                if let superview = view.superview {
                    viewLayoutCareTaker.updateLayoutOf(view,
                                                       withIdentifier: ViewControllerId.DropHint,
                                                       superview: superview,
                                                       andSiblingView: nil)
                }
            }
            
            dropHintViewController?.hintMessage = Resource.String.dropAnimatedImageHere
        }
    }
}
