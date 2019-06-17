//
//  ImageListViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class ImageListViewController: NSViewController, DragAndDropDelegate, ReordableTableViewDelegate, Parameterizable {
    
    var tableHint = String.empty {
        
        didSet {
            tableViewHint.stringValue = tableHint
        }
    }
    
    
    @IBOutlet private var tableView: ReordableTableView!
    @IBOutlet private var tableScrollView: NSScrollView!    
    @IBOutlet private var imageFilesArrayController: NSArrayController!
    
    private var tableViewDataSource: FrameListTableViewDataSource
    private let pasteboardDeclaredType = "AnimationFrame"
    

    @IBOutlet private var tableViewHint: NSTextField!
    
    required init?(coder: NSCoder) {
        tableViewDataSource = FrameListTableViewDataSource()
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateFramesDelay(notification:)),
                                               name: NSNotification.Name(NotificationIdentifier.didChangeFramesDelay.rawValue),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.setDragAndDropDelegate()
    }
    
    @objc private func updateFramesDelay(notification: Notification) {
        //tableView.reloadDataKeepingSelection()
    }
    
    // MARK: - Parameterizable
    
    func params() -> [ParameterProtocol] {
        return imageFilesArrayController.arrangedObjects as! [ImageFile]
    }
    
    // MARK: - DragAndDropImageDelegate
    
    func didDropFiles(withPaths paths: [String]) {
        
        for imagePath in paths {
            let imageSizeInKB = FileManager.default.sizeOfFile(atPath: imagePath)
            let droppedImage = ImageFile(url: URL(fileURLWithPath: imagePath) as NSURL,
                                                  size: imageSizeInKB)
            imageFilesArrayController.addObject(droppedImage)
        }
        
        self.updateUI()
    }
    
    // MARK: - ReordableTableViewDelegate
    
    func moveRow(atIndex soureIndex: Int, toIndex destinationIndex: Int) {
        let images = imageFilesArrayController.arrangedObjects as! [ImageFile]
        
        _ = images[soureIndex]
//        images.remove(at: soureIndex)
//        images.insert(animatedImageFrame, at: destinationIndex)
    }

    // MARK: - Delete event
    
    @objc func delete(_ sender: NSMenuItem) {
        imageFilesArrayController.remove(self)
        self.updateUI()
    }
    
    // MARK: - Private
    
    private func updateUI() {
        showTableViewIfNeeded()
        self.updateSelectedFramesDelayFieldsAvailability()
    }

    private func showTableViewIfNeeded() {
        
        if (imageFilesArrayController.arrangedObjects as AnyObject).count > 0 {
            tableScrollView.isHidden = false
        } else {
            tableScrollView.isHidden = true
        }
    }
    
    private func configureTableView() {
        tableScrollView.isHidden = true
//        tableView.reorderDelegate = self
//        tableView.pasteboardDeclaredType = pasteboardDeclaredType
//        tableView.dataSource = tableViewDataSource
        
//        tableViewDelegate.onSelectionChange = {
//            self.updateSelectedFramesDelayFieldsAvailability()
//        }
    }
    
    private func setDragAndDropDelegate() {
        
        if let dragAndDropView = self.view as? DragAndDropView {
            dragAndDropView.delegate = self
            dragAndDropView.allowedFileTypes = [FileExtension.png]
        }
    }
    
    private func updateSelectedFramesDelayFieldsAvailability() {
        let enableDelayFields = false
        
//        if tableView.selectedRowIndexes.count > 0 {
//            enableDelayFields = true
//        }
        
        NotificationCenter.default.post(name: NSNotification.Name(NotificationIdentifier.enableDelayFields.rawValue),
                                        object: enableDelayFields)
    }
}
