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
    
    var disassemblyArguments: DisassemblyArguments? {
        
        didSet {
            self.updateUI()
        }
    }
    
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
        disassemblyArguments?.animatedImagePath = paths[0]
        self.updateUI()
    }
    
    // MARK: - Private
    
    private func configureWebView() {
        destinationWebView.delegate = self
        destinationWebView.drawsBackground = false
        destinationWebView.mainFrame.frameView.allowsScrolling = false
    }
    
    private func updateUI() {
        
        if disassemblyArguments?.isAnimatedImagePathValid() == true {
            dropHintViewController?.view.isHidden = true
            destinationWebView.loadImage(path: disassemblyArguments!.animatedImagePath)
        } else {
            dropHintViewController?.view.isHidden = false
        }
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
