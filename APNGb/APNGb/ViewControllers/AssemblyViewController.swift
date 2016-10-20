//
//  AssemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum CheckboxIdentifier: Int {
    case play = 0, skip = 1, palette = 2, color = 3
}

enum RadioButtonIdentifier: Int {
    case zlib = 0, _7zip = 1, zopfli = 2
}

final class AssemblyViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate {
    
    private var assemblyArguments = AssemblyArguments()
    private var process: ExecutableProcess?
    private var statusViewController: StatusViewController?
    private var droppedImages: [DroppedImage] = []
    private var selectedImagesIndexSet: IndexSet?
    
    @IBOutlet private var fileNameTextField: NSTextField!
    @IBOutlet private var numberOfLoopsTextField: NSTextField!
    @IBOutlet private var _7zipIterationsTextField: NSTextField!
    @IBOutlet private var zopfliIterationsTextField: NSTextField!
    @IBOutlet private var allFramesDelaySecondsTextField: NSTextField!
    @IBOutlet private var allframesDelayFramesTextField: NSTextField!
    @IBOutlet private var selectedDelaySecondsTextField: NSTextField!
    @IBOutlet private var selectedDelayFramesTextField: NSTextField!
    @IBOutlet private var tableView: NSTableView!
    @IBOutlet private var dropImagesHereLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusView()
        tableView.register(forDraggedTypes: [NSFilenamesPboardType])
    }
    
    // MARK: - NSTableView
    
    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
        showDropImagesHereLabelIfNeeded()
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
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        
        let imageUrls = info.draggingPasteboard().readObjects(forClasses: [NSURL.self],
                                                              options: [NSPasteboardURLReadingContentsConformToTypesKey : [String(kUTTypeImage)]])
        if let urls = imageUrls {
            
            if urls.count > 0 {
                return .copy
            }
        }
        
        return []
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        let draggedImagesPaths = info.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as! Array<String>
        
        for imagePath in draggedImagesPaths {
            let imageUrl = NSURL(fileURLWithPath: imagePath)
            let fileExtension = imageUrl.lastPathComponent?.fileExtension()
            
            if let fileExtension = fileExtension {
                
                if assemblyArguments.allowedFileTypes.contains(fileExtension) {
                    let imageSizeInKB = FileManager.default.sizeOfFile(atPath: imagePath)
                    let droppedImage = DroppedImage(url: imageUrl,
                                                    size: imageSizeInKB)
                    droppedImages.append(droppedImage)
                }
            }
        }
        
        tableView.reloadData()
        showDropImagesHereLabelIfNeeded()
        
        return true
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return droppedImages.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let droppedImage = droppedImages[row]
        
        if tableColumn?.title == "Name" {
            return droppedImage.name
        } else if tableColumn?.title == "Size" {
            return "\(droppedImage.size) KB"
        } else {
            return droppedImage.displayableFrameDelay
        }
    }
    
    // MARK: IBActions
    
    @IBAction func startAssemblingProcess(_ sender: AnyObject) {
        collectArguments()
        
        if assemblyArguments.havePassedValidation() {
            self.presentViewControllerAsSheet(statusViewController!)
            let command = Command(withExecutableName: .Assembly)
            command.arguments = assemblyArguments.commandArguments()
            process = ExecutableProcess(withCommand: command)
            process?.terminationHandler = {
                self.stopAssemblingProcess()
                self.showImageInFinderApp()
            }
            process?.start()
        }
    }
    
    @IBAction func didSelectRadioButton(_ sender: NSButton) {
        assemblyArguments.compression.enable7zip = false
        _7zipIterationsTextField.isEnabled = false
        assemblyArguments.compression.enableZopfli = false
        zopfliIterationsTextField.isEnabled = false
        assemblyArguments.compression.enableZlib = false
        
        switch sender.tag {
        case RadioButtonIdentifier.zlib.rawValue:
            assemblyArguments.compression.enableZlib = Bool(sender.state)
        case RadioButtonIdentifier._7zip.rawValue:
            assemblyArguments.compression.enable7zip = Bool(sender.state)
            _7zipIterationsTextField.isEnabled = true
        case RadioButtonIdentifier.zopfli.rawValue:
            assemblyArguments.compression.enableZopfli = Bool(sender.state)
            zopfliIterationsTextField.isEnabled = true
        default:
            print("\(#function): unhandled case")
        }
    }
    
    @IBAction func didSelectCheckbox(_ sender: NSButton) {
        
        switch sender.tag {
        case CheckboxIdentifier.play.rawValue:
            assemblyArguments.playback.playIndefinitely = Bool(sender.state)
            numberOfLoopsTextField.isEnabled = !(Bool(sender.state))
        case CheckboxIdentifier.skip.rawValue:
            assemblyArguments.playback.skipFirstFrame = Bool(sender.state)
        case CheckboxIdentifier.palette.rawValue:
            assemblyArguments.optimization.enablePalette = Bool(sender.state)
        case CheckboxIdentifier.color.rawValue:
            assemblyArguments.optimization.enableColorType = Bool(sender.state)
        default:
            print("\(#function): unhandled case")
        }
    }
    
    @IBAction func showOpenPanel(_ sender: AnyObject) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.beginSheetModal(for: self.view.window!) { status in
            let destinationFolder = openPanel.urls[0]
            self.fileNameTextField.stringValue = destinationFolder.appendingPathComponent(self.defaultOutputImageName()).relativePath
        }
    }
    
    func delete(_ sender: NSMenuItem) {
        let selectedRowIndexes = tableView.selectedRowIndexes
        tableView.beginUpdates()
        tableView.removeRows(at: selectedRowIndexes, withAnimation: .slideDown)
        tableView.endUpdates()
        
        for index in selectedRowIndexes.reversed() {
            droppedImages.remove(at: index)
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let textField = (obj.object as? NSTextField)
        
        if textField == selectedDelaySecondsTextField {
            let seconds = textField?.integerValue
            
            if let indexes = selectedImagesIndexSet {
                
                for index in indexes {
                    droppedImages[index].delaySeconds = seconds!
                }
            }
        
        } else if textField == selectedDelayFramesTextField {
            let frames = textField?.integerValue
            
            if let indexes = selectedImagesIndexSet {
                
                for index in indexes {
                    droppedImages[index].delayFrames = frames!
                }
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func collectArguments() {
        assemblyArguments.destinationImagePath = fileNameTextField.stringValue
        
        for droppedImage in droppedImages {
            assemblyArguments.sourceImagesPaths.append(droppedImage.path)
        }
        
        assemblyArguments.playback.numberOfLoops = numberOfLoopsTextField.integerValue
        assemblyArguments.compression._7zipIterations = _7zipIterationsTextField.integerValue
        assemblyArguments.compression.zopfliIterations = zopfliIterationsTextField.integerValue
        assemblyArguments.allFramesDelay.seconds = allFramesDelaySecondsTextField.integerValue
        assemblyArguments.allFramesDelay.frames = allframesDelayFramesTextField.integerValue
        assemblyArguments.selectedFramesDelay.seconds = selectedDelayFramesTextField.integerValue
        assemblyArguments.selectedFramesDelay.frames = selectedDelaySecondsTextField.integerValue
    }
    
    private func setupStatusView() {
        statusViewController = storyboard?.instantiateController(withIdentifier: StoryboarId.statusView) as! StatusViewController?
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
    
    private func showDropImagesHereLabelIfNeeded() {
        
        if droppedImages.count > 0 {
            dropImagesHereLabel.isHidden = true
        } else {
            dropImagesHereLabel.isHidden = false
        }
    }
    
    private func defaultOutputImageName() -> String {
        return "output.png"
    }
    
    private func updateSelectedFramesDelayTextFields(enabled: Bool, indexSet: IndexSet?) {
        selectedImagesIndexSet = indexSet
        assemblyArguments.selectedFramesDelay.enabled = enabled
        selectedDelaySecondsTextField.isEnabled = enabled
        selectedDelayFramesTextField.isEnabled = enabled
    }
}
