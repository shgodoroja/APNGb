//
//  AssemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum CheckboxIdentifier: Int {
    case Play = 0, Skip = 1, Palette = 2, Color = 3
}

enum RadioButtonIdentifier: Int {
    case zlib = 0, _7zip = 1, zopfli = 2
}

final class AssemblyViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    private var parameters: AssemblyParameters?
    private var commandArguments: [String] = []
    private var process: ExecutableProcess?
    private var statusViewController: StatusViewController?
    private var droppedImages: [DroppedImage] = []
    
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
        parameters = AssemblyParameters()
        setupStatusView()
        tableView.register(forDraggedTypes: [NSFilenamesPboardType])
    }
    
    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
        showDropImagesHereLabelIfNeeded()
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        return .copy
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        let draggedImagesPaths = info.draggingPasteboard().propertyList(forType: NSFilenamesPboardType) as! Array<String>
        
        for imagePath in draggedImagesPaths {
            let imageUrl = NSURL(fileURLWithPath: imagePath)
            var imageSizeInKB = 0
            
            do {
                let imageAttributes = try FileManager.default.attributesOfItem(atPath: imagePath) as NSDictionary
                imageSizeInKB = Int(imageAttributes.fileSize()) / 1000
            } catch let error {
                NSLog("error: \(error)")
            }
            
            let droppedImage = DroppedImage(url: imageUrl,
                                            size: imageSizeInKB)
            droppedImages.append(droppedImage)
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
    
    private func setupStatusView() {
        statusViewController = storyboard?.instantiateController(withIdentifier: "StatusViewController") as! StatusViewController?
        statusViewController?.cancelHandler = {
            self.stopAssemblingProcess()
        }
    }
    
    private func stopAssemblingProcess() {
        statusViewController?.dismiss(nil)
        process?.stop()
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
    
    private func showImageInFinderApp() {
        let fileUrlPath = NSURL.fileURL(withPath: self.commandArguments[0])
        NSWorkspace.shared().open(fileUrlPath.deletingLastPathComponent())
    }
    
    private func collectAllArguments() {
        commandArguments.removeAll()
        
        // 1. Final image url
        commandArguments.append(fileNameTextField.stringValue)
        
        // 2. Frames urls
        for image in droppedImages {
            commandArguments.append(image.path)
        }
        
        // 3. Playback params
        if parameters?.playback.playIndefinitely == false {
            commandArguments.append("-l\(numberOfLoopsTextField.stringValue)")
        }
        
        if parameters?.playback.skipFirstFrame == true {
            commandArguments.append("-f")
        }
        
        // 4. Optimizations
        if parameters?.optimization.enablePalette == true {
            commandArguments.append("-kp")
        }
        
        if parameters?.optimization.enableColorType == true {
            commandArguments.append("-kc")
        }
        
        // 5. Compression
        if parameters?.compression.enableZlib == true {
            commandArguments.append("-z0")
        }
        
        if parameters?.compression.enable7zip == true {
            commandArguments.append("-z1")
            commandArguments.append("-i\(_7zipIterationsTextField.stringValue)")
        }
        
        if parameters?.compression.enableZopfli == true {
            commandArguments.append("-z2")
            commandArguments.append("-i\(zopfliIterationsTextField.stringValue)")
        }
        
        // 6. All frames delays
        commandArguments.append("\(allFramesDelaySecondsTextField.stringValue) \(allframesDelayFramesTextField.stringValue)")
        
        // 7. Selected frames delays
        
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
    
    // MARK: IBActions
    
    @IBAction func startAssemblingProcess(_ sender: AnyObject) {
        collectAllArguments()
        
        if haveArgumentsPassedValidation() {
            self.presentViewControllerAsSheet(statusViewController!)
            
            let command = Command(withExecutableName: .Assembly)
            command.arguments = commandArguments
            
            process = ExecutableProcess(withCommand: command)
            process?.terminationHandler = {
                self.stopAssemblingProcess()
                self.showImageInFinderApp()
            }
            process?.start()
        }
    }
    
    @IBAction func didSelectRadioButton(_ sender: NSButton) {
        parameters?.compression.enable7zip = false
        _7zipIterationsTextField.isEnabled = false
        parameters?.compression.enableZopfli = false
        zopfliIterationsTextField.isEnabled = false
        parameters?.compression.enableZlib = false
        
        switch sender.tag {
        case RadioButtonIdentifier.zlib.rawValue:
            parameters?.compression.enableZlib = Bool(sender.state)
        case RadioButtonIdentifier._7zip.rawValue:
            parameters?.compression.enable7zip = Bool(sender.state)
            _7zipIterationsTextField.isEnabled = true
        case RadioButtonIdentifier.zopfli.rawValue:
            parameters?.compression.enableZopfli = Bool(sender.state)
            zopfliIterationsTextField.isEnabled = true
        default:
            print("\(#function): unhandled case")
        }
    }
    
    @IBAction func didSelectCheckbox(_ sender: NSButton) {
        
        switch sender.tag {
        case CheckboxIdentifier.Play.rawValue:
            parameters?.playback.playIndefinitely = Bool(sender.state)
            numberOfLoopsTextField.isEnabled = !(Bool(sender.state))
        case CheckboxIdentifier.Skip.rawValue:
            parameters?.playback.skipFirstFrame = Bool(sender.state)
        case CheckboxIdentifier.Palette.rawValue:
            parameters?.optimization.enablePalette = Bool(sender.state)
        case CheckboxIdentifier.Color.rawValue:
            parameters?.optimization.enableColorType = Bool(sender.state)
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
}
