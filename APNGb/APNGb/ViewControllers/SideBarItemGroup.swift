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
    
    /// Displays a main scene.
    ///
    /// - Parameter identifier: Main scene identifier.
    func presentScene(withIdentifier identifier: MainScene)
}

/// Groups methods which manage child view controller in a scene.
protocol SceneContainerable {
    
    /// Present a child view controller in a scene.
    ///
    /// - Parameter identifier: Main scene identifier.
    func addChildViewControllerForScene(withIdentifier identifier: MainScene)
    
    /// Searches for child view controller identifier of a given scene.
    ///
    /// - Parameter identifier: Main scene identifier.
    /// - Returns: Child view controler `ViewControllerId` identifier.
    func childViewControllerIdentifierForScene(withIdentifier identifier: MainScene) -> ViewControllerId
}

/// Bundles main scene identifiers.
///
/// - AssemblyScene: `Assembling` scene.
/// - DisassemblyScene: `Disassembling` scene.
/// - OptimizeScene: `Optimize` scene.
/// - ConvertApngScene: `Convert` scene.
/// - ConvertGifScene: `Convert` scene.
/// - UnknownScene: `Unknown` scene.
enum MainScene: Int {
    case AssemblyScene
    case DisassemblyScene
    case OptimizeScene
    case ConvertScene
    case ConvertApngScene
    case ConvertGifScene
    case UnknownScene = 999
}

fileprivate extension MainScene {

    /// Search for a scene identified by an index. This
    /// doesn't match the order of identifiers from `MainScene` enum.
    ///
    /// - Parameter index: Index of the scene.
    /// - Returns: A main scene identifier. Default returns `.UnknownScene`.
    static func sceneForIndex(index: Int) -> MainScene {
        
        switch index {
        case 0:
            return .AssemblyScene
        case 1:
            return .DisassemblyScene
        case 2:
            return .OptimizeScene
        case 3:
            return .ConvertScene
        default:
            return .UnknownScene
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
        let selectedItemIndex = items.index(of: item)
        
        if let selectedItemIndex = selectedItemIndex {
            let selectedScene = MainScene.sceneForIndex(index: selectedItemIndex)
            self.delegate?.presentScene(withIdentifier: selectedScene)
            
            for item in items {
                item.state = NSControl.StateValue.off
            }
            
            item.state = NSControl.StateValue.on
        }
    }
}
