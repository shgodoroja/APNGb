//
//  PreferencesPaneViewController.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

@objc
enum ParameterIdentifier: Int {
    
    case none
    case playbackLoop
    case playbackSkipFirstFrame
    case optimizationPalette
    case optimizationColorType
    case compressionZlib
    case compression7Zip
    case compressionZopfli
    case compression7ZipIterations
    case compressionZopfliIterations
    case allFramesDelaySeconds
    case allFramesDelayFrames
    case selectedFramesDelaySeconds
    case selectedFramesDelayFrames
    case stripOrientation
    case stripNumberOfFrames
    case framePrefixeName
    case backgroundColor
    case backgroundTransparency
}

@objc
protocol ParameterProtocol {
    
    func getValue() -> String?
    func getIdentifier() -> ParameterIdentifier
}

class PreferencesOption: NSObject, ParameterProtocol {
    
    var identifier = ParameterIdentifier.none
    
    func getIdentifier() -> ParameterIdentifier {
        return identifier
    }
    
    func getValue() -> String? {
        return String.empty
    }
}

class PreferencesMockOption: NSObject, ParameterProtocol {
    
    func getIdentifier() -> ParameterIdentifier {
        return .none
    }
    
    func getValue() -> String? {
        return nil
    }
}

class ImageOption: NSObject, ParameterProtocol {
    
    var identifier = ParameterIdentifier.none
    
    func getIdentifier() -> ParameterIdentifier {
        return identifier
    }
    
    func getValue() -> String? {
        return String.empty
    }
}

class PreferencesPaneViewController: NSViewController, NSTableViewDelegate, Parameterizable {
    
    @objc dynamic var preferencesProperties = [ParameterProtocol]()
    
    private(set) var scene = Scene.Unknown
    
    @IBOutlet private var tableView: NSTableView!
    @IBOutlet private var tableViewHint: NSTextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateConvertPreferencesPane(notification:)),
                                               name: NSNotification.Name(NotificationIdentifier.animatedImageDropped.rawValue), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyle()
    }
    
    func showPreferences(forScene scene: Scene) {
        self.scene = scene
        preferencesProperties.removeAll()
        
        let tableViewDataProvider = PreferencesPaneTableViewDataProvider()
        let preferences = tableViewDataProvider.preferencesProperties(forScene: scene)
        preferencesProperties.append(contentsOf: preferences)
        
        if preferencesProperties.isEmpty {
            tableViewHint.stringValue = Resource.String.notApplicable
            tableView.isHidden = true
        } else {
            tableViewHint.stringValue = String.empty
            tableView.isHidden = false
        }
    }
        
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let preferencesProperty = preferencesProperties[row]
        let cellClassObject = self.preferencesTableCellView(forPreferencesProperty: preferencesProperty)
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellClassObject.reuseIdentifier()),
                                  owner: self)
        if cell == nil {
            cell = cellClassObject.loadNib(withOwner: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let preferencesProperty = preferencesProperties[row]
        let cellClassObject = self.preferencesTableCellView(forPreferencesProperty: preferencesProperty)
        return cellClassObject.height()
    }
    
    func preferencesTableCellView(forPreferencesProperty property: ParameterProtocol) -> BaseTableCellView.Type {
        
        if property is PreferencesSectionHeader {
            return PreferencesSectionHeaderCellView.self
        } else if property is PreferencesTextFieldWithHint {
            return PreferencesTextFieldWithHintCellView.self
        } else if property is PreferencesCheckbox {
            return PreferencesCheckboxCellView.self
        } else if property is PreferencesComboWithTextField {
            return PreferencesComboWithTextFieldCellView.self
        } else if property is PreferencesColorPicker {
            return PreferencesColorPickerCellView.self
        } else if property is PreferencesTextField {
            return PreferencesTextFieldCellView.self
        } else {
            return BaseTableCellView.self
        }
    }
    
    @objc func updateConvertPreferencesPane(notification: Notification) {
        
        if let fileExtension = notification.object as? String {
            
            if fileExtension == FileExtension.apng ||
               fileExtension == FileExtension.png {
                self.showPreferences(forScene: .ConvertApng)
            } else if fileExtension == FileExtension.gif {
                self.showPreferences(forScene: .ConvertGif)
            }
        }
    }
    
    // MARK: - Parameterizable
    
    func params() -> [ParameterProtocol] {
        return preferencesProperties
    }
    
    private func applyStyle() {
        tableView.backgroundColor = Theme.Color.preferencesPane
    }
}
