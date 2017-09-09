//
//  FrameListViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 9/18/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class FrameListViewController: NSViewController, DragAndDropDelegate, ReordableTableViewDelegate, Parameterizable {
    
    dynamic var animatedImageFrames = [AnimatedImageFrame]()
    
    private var tableViewDelegate: FrameListTableViewDelegate
    private var tableViewDataSource: FrameListTableViewDataSource
    private var dropHintViewController: DropHintViewController?
    private let pasteboardDeclaredType = "AnimationFrame"
    
    @IBOutlet private var tableView: ReordableTableView!
    @IBOutlet private var tableViewContainer: NSScrollView!
    
    required init?(coder: NSCoder) {
        tableViewDelegate = FrameListTableViewDelegate()
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
        self.addDropHintViewController()
        self.configureTableView()
        self.setDragAndDropDelegate()
    }
    
    @objc private func updateFramesDelay(notification: Notification) {
        
        tableView.reloadDataKeepingSelection()
    }
    
    private func addDropHintViewController() {
        let viewLayoutCareTaker = ChildViewLayoutCareTaker()
        
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
    
    // MARK: - Parameterizable
    
    func params() -> [ParameterProtocol] {
        return animatedImageFrames
    }
    
    // MARK: - DragAndDropImageDelegate
    
    func didDropFiles(withPaths paths: [String]) {
        
        for imagePath in paths {
            let imageSizeInKB = FileManager.default.sizeOfFile(atPath: imagePath)
            let droppedImage = AnimatedImageFrame(url: URL(fileURLWithPath: imagePath) as NSURL,
                                                  size: imageSizeInKB)
            animatedImageFrames.append(droppedImage)
        }
        
        self.updateUI()
    }
    
    // MARK: - ReordableTableViewDelegate
    
    func moveRow(atIndex soureIndex: Int, toIndex destinationIndex: Int) {
        let animatedImageFrame = animatedImageFrames[soureIndex]
        animatedImageFrames.remove(at: soureIndex)
        animatedImageFrames.insert(animatedImageFrame, at: destinationIndex)
    }

    // MARK: - Delete event
    
    func delete(_ sender: NSMenuItem) {
        let selectedRowIndexes = tableView.selectedRowIndexes.reversed()
        
        for index in selectedRowIndexes {
            animatedImageFrames.remove(at: index)
        }
        
        self.updateUI()
    }
    
    // MARK: - Private
    
    private func updateUI() {
        showTableViewIfNeeded()
        tableView.reloadData()
        self.updateSelectedFramesDelayFieldsAvailability()
    }

    private func showTableViewIfNeeded() {
        
        if animatedImageFrames.count > 0 {
            tableViewContainer.isHidden = false
        } else {
            tableViewContainer.isHidden = true
        }
    }
    
    private func configureTableView() {
        tableViewContainer.isHidden = true
        tableView.reorderDelegate = self
        tableView.pasteboardDeclaredType = pasteboardDeclaredType
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableViewDelegate.onSelectionChange = {
            self.updateSelectedFramesDelayFieldsAvailability()
        }
    }
    
    private func setDragAndDropDelegate() {
        if let dragAndDropView = self.view as? DragAndDropView {
            dragAndDropView.delegate = self
            dragAndDropView.allowedFileTypes = [FileExtension.png]
        } else {
            debugPrint("\(#function): View controller's view is not a DragAndDropView subclass. Drag & Drop will fail.")
        }
    }
    
    private func updateSelectedFramesDelayFieldsAvailability() {
        var enableDelayFields = false
        
        if tableView.selectedRowIndexes.count > 0 {
            enableDelayFields = true
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(NotificationIdentifier.enableDelayFields.rawValue),
                                        object: enableDelayFields)
    }
}
