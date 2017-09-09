//
//  PreferencesPaneTableViewDataProvider.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class PreferencesPaneTableViewDataProvider: NSObject {
    
    func preferencesPropertiesForScene(forIdentifier identifier: MainScene) -> [ParameterProtocol] {
        
        if identifier == .AssemblyScene {
            return self.assemblySceneProperties()
        } else if identifier == .DisassemblyScene {
            return self.disassemblySceneProperties()
        } else if identifier == .OptimizeScene {
            return self.optimizeSceneProperties()
        } else if identifier == .ConvertApngScene {
            return self.convertApngSceneProperties()
        } else if identifier == .ConvertGifScene {
            return self.convertGifSceneProperties()
        } else {
            return []
        }
    }
    
    // MARK: - Initialize properties
    
    func assemblySceneProperties() -> [ParameterProtocol] {
        var preferencesProperties = [ParameterProtocol]()
        
        // "Playback" section
        let playbackHeader = PreferencesSectionHeader()
        playbackHeader.title = Resource.String.playback
        preferencesProperties.append(playbackHeader)
        
        let loopSettings = PreferencesTextFieldWithHint()
        loopSettings.identifier = .playbackLoop
        loopSettings.title = Resource.String.loops
        loopSettings.hint = Resource.String.loopsHint
        loopSettings.value = 0
        preferencesProperties.append(loopSettings)
        
        let skipFirstFrameSetting = PreferencesCheckbox()
        skipFirstFrameSetting.identifier = .playbackSkipFirstFrame
        skipFirstFrameSetting.title = Resource.String.skipFirstFrame
        skipFirstFrameSetting.selected = false
        preferencesProperties.append(skipFirstFrameSetting)
        
        // "Optimizations" section
        let optimizationHeader = PreferencesSectionHeader()
        optimizationHeader.title = Resource.String.optimizations
        preferencesProperties.append(optimizationHeader)
        
        let paletteSetting = PreferencesCheckbox()
        paletteSetting.identifier = .optimizationPalette
        paletteSetting.title = Resource.String.palette
        paletteSetting.selected = true
        preferencesProperties.append(paletteSetting)
        
        let colorTypeSetting = PreferencesCheckbox()
        colorTypeSetting.identifier = .optimizationColorType
        colorTypeSetting.title = Resource.String.colorType
        colorTypeSetting.selected = true
        preferencesProperties.append(colorTypeSetting)
        
        // "Compression" section
        let compressionHeader = PreferencesSectionHeader()
        compressionHeader.title = Resource.String.compression
        preferencesProperties.append(compressionHeader)
        
        let compressionSettings = PreferencesComboWithTextField()
        compressionSettings.hint = Resource.String.iterations
        compressionSettings.comboOptions = [Resource.String.zlib,
                                            Resource.String.sevenZip,
                                            Resource.String.zopfli]
        preferencesProperties.append(compressionSettings)
        
        // "Delay" section
        let delayHeader = PreferencesSectionHeader()
        delayHeader.title = Resource.String.framesDelay
        preferencesProperties.append(delayHeader)
        
        let delaySetting = PreferencesComboWithTextField()
        delaySetting.hint = Resource.String.milliseconds
        delaySetting.comboOptions = [Resource.String.all,
                                     Resource.String.selected]
        preferencesProperties.append(delaySetting)
        
        // "Strip" section
        let stripHeader = PreferencesSectionHeader()
        stripHeader.title = Resource.String.strip
        preferencesProperties.append(stripHeader)
        
        let stripSetting = PreferencesComboWithTextField()
        stripSetting.hint = Resource.String.frames
        stripSetting.comboOptions = [Resource.String.none,
                                     Resource.String.vertical,
                                     Resource.String.horizontal]
        preferencesProperties.append(stripSetting)
        
        return preferencesProperties
    }
    
    func disassemblySceneProperties() -> [ParameterProtocol] {
        var preferencesProperties = [ParameterProtocol]()
        
        let frameHeader = PreferencesSectionHeader()
        frameHeader.title = Resource.String.frame
        preferencesProperties.append(frameHeader)
        
        let prefixNameSetting = PreferencesTextField()
        prefixNameSetting.title = Resource.String.prefixName
        prefixNameSetting.value = "frame"
        preferencesProperties.append(prefixNameSetting)
        
        return preferencesProperties
    }
    
    func optimizeSceneProperties() -> [ParameterProtocol] {
        var preferencesProperties = [ParameterProtocol]()
        
        // "Compression" section
        let compressionHeader = PreferencesSectionHeader()
        compressionHeader.title = Resource.String.compression
        preferencesProperties.append(compressionHeader)
        
        let compressionSettings = PreferencesComboWithTextField()
        compressionSettings.hint = Resource.String.iterations
        compressionSettings.comboOptions = [Resource.String.zlib,
                                            Resource.String.sevenZip,
                                            Resource.String.zopfli]
        preferencesProperties.append(compressionSettings)
        
        return preferencesProperties
    }
    
    func convertApngSceneProperties() -> [ParameterProtocol] {
        var preferencesProperties = [ParameterProtocol]()
        
        // "Background" section
        let backgroundHeader = PreferencesSectionHeader()
        backgroundHeader.title = Resource.String.background
        preferencesProperties.append(backgroundHeader)
        
        let colorPickerSetting = PreferencesColorPicker()
        colorPickerSetting.title = Resource.String.color
        colorPickerSetting.selected = false
        colorPickerSetting.value = NSColor.clear
        preferencesProperties.append(colorPickerSetting)
        
        return preferencesProperties
    }
    
    func convertGifSceneProperties() -> [ParameterProtocol] {
        var preferencesProperties = [ParameterProtocol]()
        
        // "Optimizations" section
        let optimizationHeader = PreferencesSectionHeader()
        optimizationHeader.title = Resource.String.optimizations
        preferencesProperties.append(optimizationHeader)
        
        let paletteSetting = PreferencesCheckbox()
        paletteSetting.title = Resource.String.palette
        paletteSetting.selected = true
        preferencesProperties.append(paletteSetting)
        
        // "Compression" section
        let compressionHeader = PreferencesSectionHeader()
        compressionHeader.title = Resource.String.compression
        preferencesProperties.append(compressionHeader)
        
        let compressionSettings = PreferencesComboWithTextField()
        compressionSettings.hint = Resource.String.iterations
        compressionSettings.comboOptions = [Resource.String.zlib,
                                            Resource.String.sevenZip,
                                            Resource.String.zopfli]
        preferencesProperties.append(compressionSettings)
        
        return preferencesProperties
    }
}
