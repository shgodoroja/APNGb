//
//  Command.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// Store UNIX executables names.
enum ExecutableName: String {
    case None = ""
    case Assembly = "apngasm"
    case Disassembly = "apngdis"
}

protocol ExecutableNameProtocol {
    
    /// Identifies command associated executable name.
    ///
    /// - Returns: UNIX executable name.
    func commandExecutableName() -> ExecutableName
}

extension ExecutableNameProtocol {
    
    func commandExecutableName() -> ExecutableName {
        return ExecutableName.None
    }
}

/// Specifies a set of methods used by command instance's client
/// to get it's arguments or information about them.
protocol CommandArgumentable {
    
    /// Check if arguments have passed validation.
    ///
    /// - Returns: `true` if arguments passed validation, else returns `false`.
    func havePassedValidation() -> Bool
    
    /// Provide all command's arguments to the client.
    ///
    /// - Returns: An array of arguments.
    func commandArguments() -> [String]
}

extension CommandArgumentable {
    
    func havePassedValidation() -> Bool {
        return false
    }
    
    func commandArguments() -> [String] {
        return []
    }
}

/// Describes a Terminal command.
class Command: NSObject {
    
    var name: String
    var arguments: [String]?
    
    /// Custom initializer.
    ///
    /// - Parameter name: Name of UNIX executable.
    init(withExecutableName name: ExecutableName) {
        self.name = name.rawValue
    }
}
