//
//  AssemblyViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, DragAndDropDelegate {
    
    var assemblyArguments: AssemblyArguments?
    
    private var dropHintViewController: DropHintViewController?
    private var viewLayoutCareTaker: ChildViewLayoutCareTaker
    
    @IBOutlet private var tableView: NSTableView!
    @IBOutlet private var tableViewContainer: NSScrollView!
    
    required init?(coder: NSCoder) {
        viewLayoutCareTaker = ChildViewLayoutCareTaker()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDropHintViewController()
        self.configureTableView()
        (self.view as? DragAndDropView)?.delegate = self
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
        let selectedRowIndexes = tableView.selectedRowIndexes
        for index in selectedRowIndexes.reversed() {
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
        
        guard let count = assemblyArguments?.animationFrames.count
            else {
                tableViewContainer.isHidden = true
                return
        }
        
        if count > 0 {
            tableViewContainer.isHidden = false
        } else {
            tableViewContainer.isHidden = true
        }
    }
    
    private func configureTableView() {
        tableView.unregisterDraggedTypes()
        tableViewContainer.isHidden = true
    }
}
