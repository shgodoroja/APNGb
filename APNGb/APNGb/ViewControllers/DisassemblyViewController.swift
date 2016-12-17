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
    
    private var disassemblyArguments = DisassemblyArguments()
    private var process: ExecutableProcess?
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
            
            dropHintViewController?.hintMessage = "Drop animated image here"
        }
    }
    
    // MARK: IBActions
    
    @IBAction func startDisassemblingProcess(_ sender: AnyObject) {
        
        if disassemblyArguments.havePassedValidation() {
            //self.presentViewControllerAsSheet(statusViewController!)
            let command = Command(withExecutableName: .Disassembly)
            command.arguments = disassemblyArguments.commandArguments()
            
            process = ExecutableProcess(withCommand: command)
            process?.progressHandler = { outputString in
                //self.statusViewController?.updateStatusMessage(message: outputString)
            }
            process?.terminationHandler = {
                self.stopDisassemblingProcess()
                
                //if self.statusViewController?.wasCanceled() == true {
                    self.removeOutputImages()
                //} else {
                    self.showImageFramesInFinderApp()
                //}
            }
            process?.start()
        }
    }
    
    
    // MARK: - DragAndDropImageViewDelegate
    
    func didDropFiles(withPaths paths: [String]) {
        dropHintViewController?.view.isHidden = true
    }
    
    // MARK: - Private
    
    private func configureWebView() {
        destinationWebView.delegate = self
        destinationWebView.drawsBackground = false
        destinationWebView.mainFrame.frameView.allowsScrolling = false
    }
    
    private func stopDisassemblingProcess() {
        //statusViewController?.dismiss(nil)
        process?.stop()
    }
    
    private func showImageFramesInFinderApp() {
        //let fileUrl = NSURL.fileURL(withPath: disassemblyArguments.destinationImagesPath)
        //NSWorkspace.shared().open(fileUrl)
    }
    
    private func removeOutputImages() {
        // TODO:
    }
}
