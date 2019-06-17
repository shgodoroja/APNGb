//
//  SideBarItemGroup.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/7/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// Declares methods for displaying main scenes.
/// A scene represents a collection of presented views.
protocol ScenePresentable {
    
    /// Displays a scene.
    ///
    /// - Parameter identifier: Scene identifier.
    func present(scene: Scene)
}

/// Groups methods which manage child view controller in a scene.
protocol SceneContainerable {
    
    /// Present a child view controller in a scene.
    ///
    /// - Parameter identifier: Scene identifier.
    func addChildViewController(forScene scene: Scene)
}

/// Bundles main scene identifiers.
///
/// - Assembly: `Assembling` scene.
/// - Disassembly: `Disassembling` scene.
/// - Optimize: `Optimize` scene.
/// - ConvertApng: `Convert` scene.
/// - ConvertGif: `Convert` scene.
/// - Unknown: `Unknown` scene.
enum Scene: Int {
    case Assembly
    case Disassembly
    case Optimize
    case Convert
    case ConvertApng
    case ConvertGif
    case Unknown
}

fileprivate extension Scene {

    /// Search for a scene identified by an index. This
    /// doesn't match the order of identifiers from `Scene` enum.
    ///
    /// - Parameter index: Index of the scene.
    /// - Returns: A scene identifier. Default returns `.UnknownScene`.
    static func at(index: Int) -> Scene {
        
        switch index {
        case 0:
            return .Assembly
        case 1:
            return .Disassembly
        case 2:
            return .Optimize
        case 3:
            return .Convert
        default:
            return .Unknown
        }
    }
}

class SideBarItemGroup: NSObject {
    
    var delegate: ScenePresentable?
    
    private var items: [NSButton] = []
    
    func addItem(item: NSButton) {
        item.target = self
        item.action = #selector(didClickOn(item:))
        items.append(item)
    }
    
    func selectItem(item: NSButton) {
        
        if items.contains(item) {
            self.didClickOn(item: item)
        }
    }
    
    // MARK: - Private
    
    @objc
    private func didClickOn(item: NSButton) {
        let selectedItemIndex = items.firstIndex(of: item)
        
        if let selectedItemIndex = selectedItemIndex {
            let selectedScene = Scene.at(index: selectedItemIndex)
            self.delegate?.present(scene: selectedScene)
            
            for item in items {
                item.state = NSControl.StateValue.off
            }
            
            item.state = NSControl.StateValue.on
        }
    }
}
