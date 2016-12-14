//
//  DisassemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyViewController: NSViewController, NSTextFieldDelegate, DragAndDropImageDelegate {
    
    var delegate: Droppable?
    
    private var disassemblyArguments = DisassemblyArguments()
    private var process: ExecutableProcess?
    
    @IBOutlet private var destinationWebView: DragAndDropWebView! {
        didSet {
            destinationWebView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
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
    
    func didDropImages(withPaths paths: [String]) {
        self.delegate?.contentWasDropped()
    }
    
    // MARK: - Private
    
    private func configureWebView() {
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
