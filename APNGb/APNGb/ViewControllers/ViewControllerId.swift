//
//  ViewControllerId.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/10/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

enum ViewControllerId: Int {
    case Assembly
    case Disassembly
    case Status
    case Preferences
    case DropHint
    case BottomToolbar
    case ChildContainer
    case SideBar
    case AssemblyPreferences
    case DisassemblyPreferences
    case Unknown = 999
}

extension ViewControllerId {
    
    init(fromRawValue: Int) {
        self = ViewControllerId(rawValue: fromRawValue) ?? .Unknown
    }
    
    func storyboardVersion() -> String {
        switch self {
        case .Assembly:
            return "assembly.view"
        case .Disassembly:
            return "disassembly.view"
        case .Status:
            return "status.view"
        case .Preferences:
            return "preferences.view"
        case .DropHint:
            return "drophint.view"
        case .BottomToolbar:
            return "bottomtoolbar.view"
        case .ChildContainer:
            return "childcontainer.view"
        case .AssemblyPreferences:
            return "assemblypreferences.view"
        case .DisassemblyPreferences:
            return "disassemblypreferences.view"
        default:
            return String.empty
        }
    }
}
