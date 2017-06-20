//
//  PreferencesDelay.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/14/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum FrameDelayCategory {
    case All, Selected, None
}

final class PreferencesDelay: PreferencesOption {
    
    var title = String.empty
    var enabled = true
    var category = FrameDelayCategory.None
    var secondValue = 0
    var frameValue = 0
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setEnabled(notification:)),
                                               name: NSNotification.Name(NotificationIdentifier.enableDelayFields.rawValue),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(PreferencesDelay.secondValue) {
            secondValue = 0
        }
        
        if key == #keyPath(PreferencesDelay.frameValue) {
            frameValue = 0
        }
    }
    
    override func didChangeValue(forKey key: String) {
        
        if key == #keyPath(PreferencesDelay.secondValue) ||
           key == #keyPath(PreferencesDelay.frameValue) {
            self.notifyObservers()
        }
        
        super.didChangeValue(forKey: key)
    }
    
    func setEnabled(notification: Notification) {
        
        if let enabled = notification.object as? Bool {
            
            if self.category == .Selected {
                self.setValue(enabled, forKey: #keyPath(PreferencesDelay.enabled))
            }
        }
    }
    
    private func notifyObservers() {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationIdentifier.didChangeFramesDelay.rawValue),
                                        object: self)
    }
}
