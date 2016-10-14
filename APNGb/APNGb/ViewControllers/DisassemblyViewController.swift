//
//  DisassemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyViewController: NSViewController, DragAndDropImageViewDelegate {
    
    private var commandArguments: [String] = ["", ""]
    private var process: ExecutableProcess?
    private var statusViewController: StatusViewController?
    
    @IBOutlet private var fileNameTextField: NSTextField!
    @IBOutlet private var startButton: NSButton!
    @IBOutlet var destinationImageView: DragAndDropImageView!
    @IBOutlet var dragAndDropPlaceholder: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationImageView.delegate = self
        setupStatusView()
    }
    
    private func setupStatusView() {
        statusViewController = storyboard?.instantiateController(withIdentifier: "StatusViewController") as! StatusViewController?
        statusViewController?.cancelHandler = {
            self.stopDisassemblingProcess()
        }
    }
    
    // MARK: IBActions
    
    @IBAction func startDisassemblingProcess(_ sender: AnyObject) {
        commandArguments[1] = (filenamePrefix() + outputFilenameExtension())
    
        if haveArgumentsPassedValidation() {
            self.presentViewControllerAsSheet(statusViewController!)
            
            let command = Command(withExecutableName: .Disassembly)
            command.arguments = commandArguments
            
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
        commandArguments[0] = path
        setDefaultOutputFilenamePrefixIfNeeded()
        dragAndDropPlaceholder.isHidden = true
    }
    
    // MARK: - Private
    
    private func stopDisassemblingProcess() {
        statusViewController?.dismiss(nil)
        process?.stop()
    }
    
    private func showImageFramesInFinderApp() {
        let fileUrlPath = NSURL.fileURL(withPath: self.commandArguments[0])
        NSWorkspace.shared().open(fileUrlPath.deletingLastPathComponent())
    }
    
    private func setDefaultOutputFilenamePrefixIfNeeded() {
        
        if fileNameTextField.stringValue.characters.count == 0 {
            fileNameTextField.stringValue = defaultFilenamePrefix()
        }
    }
    
    private func filenamePrefix() -> String {
        
        if fileNameTextField.stringValue.characters.count == 0 {
            return defaultFilenamePrefix()
        } else {
            return fileNameTextField.stringValue
        }
    }
    
    // TODO: Fix validation
    private func haveArgumentsPassedValidation() -> Bool {
        
        for argument in commandArguments {
            
            if argument.characters.count == 0 {
                return false
            }
        }
        
        return true
    }
    
    private func defaultFilenamePrefix() -> String {
        return "apngframe"
    }
    
    private func outputFilenameExtension() -> String {
        return ".png"
    }
}
