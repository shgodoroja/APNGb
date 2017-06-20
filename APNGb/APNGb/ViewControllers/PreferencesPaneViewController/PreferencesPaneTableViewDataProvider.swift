//
//  PreferencesPaneTableViewDataProvider.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/16/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum StripOrientation: String  {
    case vertical = "Vertical"
    case horizontal = "Horizontal"
    
    static func argumentValue(for orientation: String) -> String {
        
        if orientation == vertical.rawValue {
            return Argument.verticalStrip
        } else if orientation == horizontal.rawValue {
            return Argument.horizontalStrip
        }  else {
            return String.empty
        }
    }
}

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
        
        let zlibRadio = PreferencesRadio()
        zlibRadio.identifier = .compressionZlib
        zlibRadio.title = Resource.String.zlib
        zlibRadio.selected = false
        preferencesProperties.append(zlibRadio)
        
        let sevenZipRadio = PreferencesRadioWithTextField()
        sevenZipRadio.identifier = .compression7Zip
        sevenZipRadio.title = Resource.String.sevenZip
        sevenZipRadio.subtitle = Resource.String.iterations
        sevenZipRadio.selected = true
        sevenZipRadio.value = 15
        preferencesProperties.append(sevenZipRadio)
        
        let zopfliRadio = PreferencesRadioWithTextField()
        zopfliRadio.identifier = .compressionZopfli
        zopfliRadio.title = Resource.String.zopfli
        zopfliRadio.subtitle = Resource.String.iterations
        zopfliRadio.selected = false
        zopfliRadio.value = 15
        preferencesProperties.append(zopfliRadio)
        
        // "All frames delay" section
        let allFramesDelayHeader = PreferencesSectionHeader()
        allFramesDelayHeader.title = Resource.String.allFramesDelay
        preferencesProperties.append(allFramesDelayHeader)
        
        let allFrameDelaySetting = PreferencesDelay()
        allFrameDelaySetting.title = Resource.String.seconds
        allFrameDelaySetting.secondValue = 1
        allFrameDelaySetting.frameValue = 10
        allFrameDelaySetting.category = .All
        preferencesProperties.append(allFrameDelaySetting)
        
        // "Selected frames delay" section
        let selectedFramesDelayHeader = PreferencesSectionHeader()
        selectedFramesDelayHeader.title = Resource.String.selectedFramesDelay
        preferencesProperties.append(selectedFramesDelayHeader)
        
        let selectedFramesDelaySetting = PreferencesDelay()
        selectedFramesDelaySetting.title = Resource.String.seconds
        selectedFramesDelaySetting.secondValue = 1
        selectedFramesDelaySetting.enabled = false
        selectedFramesDelaySetting.frameValue = 10
        selectedFramesDelaySetting.category = .Selected
        preferencesProperties.append(selectedFramesDelaySetting)
        
        // "Strip" section
        let stripHeader = PreferencesSectionHeader()
        stripHeader.title = Resource.String.strip
        preferencesProperties.append(stripHeader)
        
        let stripSetting = PreferencesComboWithTextField()
        stripSetting.comboContent = [StripOrientation.vertical.rawValue,
                                     StripOrientation.horizontal.rawValue]
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
        
        let zlibRadio = PreferencesRadio()
        zlibRadio.title = Resource.String.zlib
        zlibRadio.selected = false
        preferencesProperties.append(zlibRadio)
        
        let sevenZipRadio = PreferencesRadioWithTextField()
        sevenZipRadio.title = Resource.String.sevenZip
        sevenZipRadio.subtitle = Resource.String.iterations
        sevenZipRadio.selected = true
        sevenZipRadio.value = 15
        preferencesProperties.append(sevenZipRadio)
        
        let zopfliRadio = PreferencesRadioWithTextField()
        zopfliRadio.title = Resource.String.zopfli
        zopfliRadio.subtitle = Resource.String.iterations
        zopfliRadio.selected = false
        zopfliRadio.value = 15
        preferencesProperties.append(zopfliRadio)
        
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
        
        let thresholdLevelSetting = PreferencesTextFieldWithStepper()
        thresholdLevelSetting.title = Resource.String.transparency
        thresholdLevelSetting.selected = true
        thresholdLevelSetting.stepperMinValue = 0
        thresholdLevelSetting.stepperMaxValue = 128
        thresholdLevelSetting.value = 128
        preferencesProperties.append(thresholdLevelSetting)
    
        let options = [NSValueTransformerNameBindingOption: NSValueTransformerName.negateBooleanTransformerName]
        colorPickerSetting.bind(#keyPath(PreferencesColorPicker.selected),
                                to: thresholdLevelSetting,
                                withKeyPath: #keyPath(PreferencesTextFieldWithStepper.selected),
                                options: options)
        thresholdLevelSetting.bind(#keyPath(PreferencesTextFieldWithStepper.selected),
                                to: colorPickerSetting,
                                withKeyPath: #keyPath(PreferencesColorPicker.selected),
                                options: options)
        
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
        
        let zlibRadio = PreferencesRadio()
        zlibRadio.title = Resource.String.zlib
        zlibRadio.selected = false
        preferencesProperties.append(zlibRadio)
        
        let sevenZipRadio = PreferencesRadioWithTextField()
        sevenZipRadio.title = Resource.String.sevenZip
        sevenZipRadio.subtitle = Resource.String.iterations
        sevenZipRadio.selected = true
        sevenZipRadio.value = 15
        preferencesProperties.append(sevenZipRadio)
        
        let zopfliRadio = PreferencesRadioWithTextField()
        zopfliRadio.title = Resource.String.zopfli
        zopfliRadio.subtitle = Resource.String.iterations
        zopfliRadio.selected = false
        zopfliRadio.value = 15
        preferencesProperties.append(zopfliRadio)
    
        return preferencesProperties
    }
}
