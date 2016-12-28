//
//  AssemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, DragAndDropDelegate {
    
    var assemblyArguments: AssemblyArguments? {
        
        didSet {
            self.updateUI()
        }
    }
    
    private var dropHintViewController: DropHintViewController?
    private var viewLayoutCareTaker: ChildViewLayoutCareTaker
    
    private let animationFrameType = "AnimationFrame"
    
    @IBOutlet private var tableView: NSTableView!
    @IBOutlet private var tableViewContainer: NSScrollView!
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = ChildViewLayoutCareTaker()
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDropHintViewController()
        self.configureTableView()
        self.setDragAndDropDelegate()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateAllFramesDelay(sender:)),
                                               name: NSNotification.Name(NotificationIdentifier.didChangeAllFramesDelay.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateSelectedFramesDelay(sender:)),
                                               name: NSNotification.Name(NotificationIdentifier.didChangeSelectedFramesDelay.rawValue),
                                               object: nil)
    }
    
    @objc private func updateAllFramesDelay(sender: Notification) {
        let allFramesDelay = assemblyArguments?.allFramesDelay
        let frames = assemblyArguments?.animationFrames
        
        if let allFramesDelay = allFramesDelay {
        
            if let frames = frames {
                
                for frame in frames {
                    frame.delayFrames = allFramesDelay.frames
                    frame.delaySeconds = allFramesDelay.seconds
                }
            }
        }

        tableView.reloadDataKeepingSelection()
    }
    
    @objc private func updateSelectedFramesDelay(sender: Notification) {
        let selectedFramesDelay = assemblyArguments?.selectedFramesDelay
        let frames = assemblyArguments?.animationFrames
        
        if let selectedFramesDelay = selectedFramesDelay {
            
            if let frames = frames {
                
                for index in tableView.selectedRowIndexes {
                    let frame = frames[index]
                    frame.delayFrames = selectedFramesDelay.frames
                    frame.delaySeconds = selectedFramesDelay.seconds
                }
            }
        }
        
        tableView.reloadDataKeepingSelection()
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
            
            dropHintViewController?.hintMessage = Resource.String.dropFramesHere
        }
    }
    
    // MARK: - NSTableView
    
    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
        updateUI()
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if tableView.selectedRowIndexes.count > 0 {
            assemblyArguments?.selectedFramesDelay.setValue(true, forKey: #keyPath(FrameDelay.enabled))
        } else {
            assemblyArguments?.selectedFramesDelay.setValue(false, forKey: #keyPath(FrameDelay.enabled))
        }
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        if let assemblyArguments = assemblyArguments {
            return assemblyArguments.animationFrames.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.make(withIdentifier: AssemblyFrameCellView.identifier(),
                                      owner: self) as! AssemblyFrameCellView
        
        let imageFrame = assemblyArguments?.animationFrames[row]
        
        if let imageFrame = imageFrame {
            cellView.imageView!.image = NSImage(contentsOf: NSURL(fileURLWithPath: imageFrame.path) as URL)
            cellView.nameTextField.stringValue = imageFrame.name
            cellView.sizeTextField.stringValue = "\(Resource.String.size)\(String.colon) \(imageFrame.size) \(String.kilobyteAbbreviation)"
            cellView.delayTextField.stringValue = "\(Resource.String.delay)\(String.colon) \(imageFrame.displayableFrameDelay)"
        }
        
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return AssemblyFrameRowView()
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        pboard.declareTypes([animationFrameType], owner: self)
        pboard.setData(data, forType: animationFrameType)
        
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        
        if dropOperation == .above {
            return .move
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        let pasteboard = info.draggingPasteboard()
        let pasteboardData = pasteboard.data(forType: animationFrameType)
        
        if let pasteboardData = pasteboardData {
            
            if let rowIndexes = NSKeyedUnarchiver.unarchiveObject(with: pasteboardData) as? IndexSet {
                var oldIndex = 0
                var newIndex = 0
                
                for rowIndex in rowIndexes {
                    
                    if rowIndex < row {
                        self.replaceAnimationFrame(atIndex: (rowIndex + oldIndex),
                                                   toIndex: (row - 1))
                        tableView.moveRow(at: rowIndex + oldIndex, to: row - 1)
                        oldIndex -= 1
                    } else {
                        self.replaceAnimationFrame(atIndex: rowIndex,
                                                   toIndex: (row + newIndex))
                        tableView.moveRow(at: rowIndex, to: row + newIndex)
                        newIndex += 1
                    }
                }
            }
        }
        
        return true
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return AssemblyFrameCellView.height()
    }
    
    // MARK: - DragAndDropImageDelegate
    
    func didDropFiles(withPaths paths: [String]) {
        
        for imagePath in paths {
            let imageSizeInKB = FileManager.default.sizeOfFile(atPath: imagePath)
            let droppedImage = AnimationFrame(url: URL(fileURLWithPath: imagePath) as NSURL,
                                              size: imageSizeInKB)
            assemblyArguments?.animationFrames.append(droppedImage)
        }
        
        updateUI()
    }

    // MARK: - Delete event
    
    func delete(_ sender: NSMenuItem) {
        let selectedRowIndexes = tableView.selectedRowIndexes.reversed()
        for index in selectedRowIndexes {
            assemblyArguments?.animationFrames.remove(at: index)
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func updateUI() {
        showTableViewIfNeeded()
        tableView.reloadData()
    }

    private func showTableViewIfNeeded() {
        
        if let count = assemblyArguments?.animationFrames.count {
            
            if count > 0 {
                tableViewContainer.isHidden = false
            } else {
                tableViewContainer.isHidden = true
            }
            
        } else {
            tableViewContainer.isHidden = true
        }
    }
    
    private func configureTableView() {
        tableView.register(forDraggedTypes: [animationFrameType])
        tableViewContainer.isHidden = true
    }
    
    private func setDragAndDropDelegate() {
        if let dragAndDropView = self.view as? DragAndDropView {
            dragAndDropView.delegate = self
        } else {
            debugPrint("\(#function): View Controller's view is not a DragAndDropView subclass. Drag & Drop will fail.")
        }
    }
    
    private func replaceAnimationFrame(atIndex soureIndex: Int, toIndex destinationIndex: Int) {
        let frame = assemblyArguments?.animationFrames[soureIndex]
        assemblyArguments?.animationFrames.remove(at: soureIndex)
        assemblyArguments?.animationFrames.insert(frame!, at: destinationIndex)
    }
}
