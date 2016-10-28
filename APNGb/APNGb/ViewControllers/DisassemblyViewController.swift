//
//  DisassemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyViewController: NSViewController, DragAndDropImageDelegate, NSTextFieldDelegate {
    
    private var disassemblyArguments = DisassemblyArguments()
    private var process: ExecutableProcess?
    private var statusViewController: StatusViewController?
    
    @IBOutlet private var startButton: NSButton!
    @IBOutlet private var fileNameTextField: NSTextField!
    @IBOutlet private var dropHintLabel: NSTextField!
    @IBOutlet private var destinationWebView: DragAndDropWebView! {
        didSet {
            destinationWebView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStatusView()
        configureWebView()
    }
    
    // MARK: IBActions
    
    @IBAction func startDisassemblingProcess(_ sender: AnyObject) {
        
        if disassemblyArguments.havePassedValidation() {
            self.presentViewControllerAsSheet(statusViewController!)
            let command = Command(withExecutableName: .Disassembly)
            command.arguments = disassemblyArguments.commandArguments()
            process = ExecutableProcess(withCommand: command)
            process?.terminationHandler = {
                self.stopDisassemblingProcess()
                self.showImageFramesInFinderApp()
            }
            process?.start()
        }
    }
    
    @IBAction func showOpenPanel(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.beginSheetModal(for: self.view.window!) { wasDirectoredSelected in
            
            if Bool(wasDirectoredSelected) {
                let destinationFolder = openPanel.urls[0]
                self.disassemblyArguments.destinationImagesPath = destinationFolder.path
                self.disassemblyArguments.destinationImagesNamePrefix = DisassemblyArguments.defaultDestinationImagesNamePrefix()
                self.fileNameTextField.stringValue = self.disassemblyArguments.destinationImagesFullPath()
            }
        }
    }
    
    // MARK: - DragAndDropImageViewDelegate
    
    func didDropImage(withPath path: String) {
        disassemblyArguments.sourceImagePath = path
        dropHintLabel.isHidden = true
    }
    
    // MARK: - NSTextFieldDelegate
    
    override func controlTextDidChange(_ obj: Notification) {
        
        if let textField = (obj.object as? NSTextField) {
            
            if textField.stringValue.characters.count > 0 {
                let pathComponents = textField.stringValue.components(separatedBy: String.slash)
                
                if let lastPathComponent = pathComponents.last {
                    disassemblyArguments.destinationImagesNamePrefix = lastPathComponent
                }
                
                let folderPath = URL(fileURLWithPath: textField.stringValue).deletingLastPathComponent().path
                disassemblyArguments.destinationImagesPath = folderPath
            }
        }
    }
    
    // MARK: - Private
    
    private func configureStatusView() {
        statusViewController = storyboard?.instantiateController(withIdentifier: StoryboarId.statusView) as! StatusViewController?
        statusViewController?.cancelHandler = {
            self.stopDisassemblingProcess()
        }
    }
    
    private func configureWebView() {
        destinationWebView.drawsBackground = false
        destinationWebView.mainFrame.frameView.allowsScrolling = false
    }
    
    private func stopDisassemblingProcess() {
        statusViewController?.dismiss(nil)
        process?.stop()
    }
    
    private func showImageFramesInFinderApp() {
        let fileUrl = NSURL.fileURL(withPath: disassemblyArguments.destinationImagesPath)
        NSWorkspace.shared().open(fileUrl)
    }
}
