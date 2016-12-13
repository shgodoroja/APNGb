//
//  AssemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum DroppedImageTableViewColumnIdentifier: String {
    case name = "name", size = "size", delay = "delay"
}

final class AssemblyViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, DragAndDropImageDelegate {
    
    private var assemblyArguments = AssemblyArguments()
    private var process: ExecutableProcess?
    
    private var animationFrames: [AnimationFrame] = []
    private var selectedImagesIndexSet: IndexSet?

    private var statusViewController: StatusViewController?
    
    @IBOutlet private var tableView: NSTableView!
    @IBOutlet private var tableViewScrollView: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStatusView()
    }
    
    // MARK: - NSTableView
    
    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
        updateUI()
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedRowIndexes = tableView.selectedRowIndexes
        
        if selectedRowIndexes.count > 0 {
            updateSelectedFramesDelayTextFields(enabled: true, indexSet: selectedRowIndexes)
        } else {
            updateSelectedFramesDelayTextFields(enabled: false, indexSet: nil)
        }
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return animationFrames.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let droppedImage = animationFrames[row]
        
        if tableColumn?.identifier == DroppedImageTableViewColumnIdentifier.name.rawValue {
            return droppedImage.name
        } else if tableColumn?.identifier == DroppedImageTableViewColumnIdentifier.size.rawValue {
            return "\(droppedImage.size)" + String.space + String.kilobyteAbbreviation
        } else {
            return droppedImage.displayableFrameDelay
        }
    }
    
    // MARK: DragAndDropImageDelegate
    
    func didDropImages(withPaths paths: [String]) {
        
        for imagePath in paths {
            let imageSizeInKB = FileManager.default.sizeOfFile(atPath: imagePath)
            let droppedImage = AnimationFrame(url: URL(fileURLWithPath: imagePath) as NSURL,
                                            size: imageSizeInKB)
            animationFrames.append(droppedImage)
        }
    
        tableView.reloadData()
        updateUI()
    }

    // MARK: IBActions

    @IBAction func startAssemblingProcess(_ sender: AnyObject) {
        //collectArguments()
        preProcessSetup()
        
        if assemblyArguments.havePassedValidation() {
            self.presentViewControllerAsSheet(statusViewController!)
            let command = Command(withExecutableName: .Assembly)
            command.arguments = assemblyArguments.commandArguments()
            process = ExecutableProcess(withCommand: command)
            process?.progressHandler = { outputString in
                self.statusViewController?.updateStatusMessage(message: outputString)
            }
            process?.terminationHandler = {
                self.stopAssemblingProcess()
                
                if self.statusViewController?.wasCanceled() == true {
                    self.removeOutputImage()
                } else {
                    self.showImageInFinderApp()
                }
            }
            process?.start()
        }
    }
    
    func delete(_ sender: NSMenuItem) {
        let selectedRowIndexes = tableView.selectedRowIndexes
        tableView.beginUpdates()
        tableView.removeRows(at: selectedRowIndexes, withAnimation: .slideDown)
        tableView.endUpdates()
        
        for index in selectedRowIndexes.reversed() {
            animationFrames.remove(at: index)
        }
    }
    
    // MARK: - Private
    
    private func preProcessSetup() {
        let imageFolderUrl = createImageCopiesFolder()
        
        if let folderUrl = imageFolderUrl {
            let imageNamePrefix = "frame"
            var index = 0
            copyImagesToFolder(withPath: folderUrl.path,
                               imageNamePrefix: imageNamePrefix,
                               andIndex: index)
            reset(index: &index)
            createImageMetadataFilesToFolder(withUrl: folderUrl,
                                             imageNamePrefix: imageNamePrefix,
                                             andIndex: index)
        }
    }
    
    func createImageCopiesFolder() -> URL? {
        let imagesFolderName = "APNGbImages"
        let imagesFolderUrl = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagesFolderName, isDirectory: true)
        
        if let folderUrl = imagesFolderUrl {
            let folderWasRemoved = FileManager.default.removeItemIfExists(atPath: folderUrl.path)
            
            if folderWasRemoved {
                do {
                    try FileManager.default.createDirectory(at: folderUrl,
                                                            withIntermediateDirectories: true,
                                                            attributes: nil)
                } catch let error {
                    NSLog("\(#function): \(error)")
                    return nil
                }
                
                return folderUrl
            }
        }
        
        return nil
    }
    
    private func copyImagesToFolder(withPath path: String, imageNamePrefix: String, andIndex index: Int) {
        var index = index
        
        for droppedImage in animationFrames {
            
            do {
                let newImageName = "\(imageNamePrefix)\(index).\(droppedImage.name.fileExtension())"
                try FileManager.default.copyItem(atPath: droppedImage.path,
                                                 toPath: path.appending("/\(newImageName)"))
                if index == 0 {
                    assemblyArguments.sourceImagePath = path.appending("/\(newImageName)")
                }
                
            } catch let error {
                NSLog("\(#function): \(error)")
            }
            
            index += 1
        }
    }
    
    private func createImageMetadataFilesToFolder(withUrl url: URL, imageNamePrefix: String, andIndex index: Int) {
        var index = index
        
        for droppedImage in animationFrames {
            let textFileName = "\(imageNamePrefix)\(index)"
            let filePath = url.appendingPathComponent("\(textFileName).txt").path
            FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
            let contentWithDelayValue = "delay=\(droppedImage.displayableFrameDelay)"
            FileManager.default.writeToFile(content: contentWithDelayValue,
                                            filePath: filePath)
            index += 1
        }
    }
    
    private func reset(index: inout Int) {
        index = 0
    }
    
    private func setupStatusView() {
        statusViewController = storyboard?.instantiateController(withIdentifier: ViewControllerId.Status.storyboardVersion()) as! StatusViewController?
        statusViewController?.cancelHandler = {
            self.stopAssemblingProcess()
        }
    }
    
    private func stopAssemblingProcess() {
        statusViewController?.dismiss(nil)
        process?.stop()
    }
    
    private func showImageInFinderApp() {
        let fileUrlPath = NSURL.fileURL(withPath: assemblyArguments.destinationImagePath)
        NSWorkspace.shared().open(fileUrlPath.deletingLastPathComponent())
    }
    
    private func updateUI() {
        showTableViewIfNeeded()
        //showDropHintViewIfNeeded()
    }
    
//    private func showDropHintViewIfNeeded() {
//        
//        if droppedImages.count > 0 {
//            dropHintViewController?.view.isHidden = true
//        } else {
//            dropHintViewController?.view.isHidden = false
//        }
//    }
    
    private func showTableViewIfNeeded() {
        
        if animationFrames.count > 0 {
            tableViewScrollView.isHidden = false
        } else {
            tableViewScrollView.isHidden = true
        }
    }
    
    private func defaultOutputImageName() -> String {
        return "output.png"
    }
    
    private func updateSelectedFramesDelayTextFields(enabled: Bool, indexSet: IndexSet?) {
        selectedImagesIndexSet = indexSet
        assemblyArguments.selectedFramesDelay.enabled = enabled
        //selectedDelaySecondsTextField.isEnabled = enabled
        //selectedDelayFramesTextField.isEnabled = enabled
    }

    private func removeOutputImage() {
        _ = FileManager.default.removeItemIfExists(atPath: self.assemblyArguments.destinationImagePath)
    }
    
//    private func configureDropHintView() {
//        dropHintViewController?.hintMessage = "Drop images here"
//    }
}
