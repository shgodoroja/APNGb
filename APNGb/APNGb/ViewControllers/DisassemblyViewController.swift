//
//  DisassemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyViewController: NSViewController, DragAndDropImageViewDelegate, NSTextFieldDelegate {
    
    private var disassemblyArguments = DisassemblyArguments()
    private var process: ExecutableProcess?
    private var statusViewController: StatusViewController?
    
    @IBOutlet private var fileNameTextField: NSTextField!
    @IBOutlet private var startButton: NSButton!
    @IBOutlet private var dropHintLabel: NSTextField!
    @IBOutlet private var destinationImageView: DragAndDropImageView! {
        didSet {
            destinationImageView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusView()
    }
    
    private func setupStatusView() {
        statusViewController = storyboard?.instantiateController(withIdentifier: StoryboarId.statusView) as! StatusViewController?
        statusViewController?.cancelHandler = {
            self.stopDisassemblingProcess()
        }
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
    
    // MARK: - DragAndDropImageViewDelegate
    
    func didDropImage(withPath path: String) {
        disassemblyArguments.sourceImagePath = path
        setDefaultOutputFilenamePrefixIfNeeded(prefix: defaultOutputFilenamePrefix())
        dropHintLabel.isHidden = true
    }
    
    // MARK: - NSTextFieldDelegate
    
    override func controlTextDidChange(_ obj: Notification) {
        
        if let textField = (obj.object as? NSTextField) {
            disassemblyArguments.destinationImageNamePrefix = textField.stringValue
        }
    }
    
    // MARK: - Private
    
    private func stopDisassemblingProcess() {
        statusViewController?.dismiss(nil)
        process?.stop()
    }
    
    private func showImageFramesInFinderApp() {
        let fileUrl = NSURL.fileURL(withPath: disassemblyArguments.sourceImagePath)
        NSWorkspace.shared().open(fileUrl.deletingLastPathComponent())
    }
    
    private func setDefaultOutputFilenamePrefixIfNeeded(prefix: String) {
        
        if fileNameTextField.stringValue.characters.count == 0 {
            fileNameTextField.stringValue = prefix
            disassemblyArguments.destinationImageNamePrefix = prefix
        }
    }

    private func defaultOutputFilenamePrefix() -> String {
        return "frame"
    }
    
}
