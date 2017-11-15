//
//  PreviewImageViewController.swift
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

final class PreviewImageViewController: NSViewController {
        
    @IBOutlet private var destinationWebView: DragAndDropWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWebView()
    }
    
    // MARK: - Private
    
    private func configureWebView() {
        destinationWebView.drawsBackground = false
        destinationWebView.mainFrame.frameView.allowsScrolling = false
    }
}
