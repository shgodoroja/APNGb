//
//  Command.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// Makes type to reset it's valuee to initial.
protocol Reseatable {
    
    func reset()
}

/// Stores UNIX executables names.
enum CommandExecutable: String {
    case none = ""
    case assembly = "apngasm"
    case disassembly = "apngdis"
    case optimize = "apngopt"
    case convertApng = "apng2gif"
    case convertGif = "gif2apng"
}

/// Specifies a set of methods used by command instance's client
/// to get it's arguments or information about them.
protocol CommandArgumentable {
    
    /// Check if arguments have passed validation.
    ///
    /// - Returns: `true` if arguments passed validation, else returns `false`.
    func validated() -> Bool
    
    /// Returns command arguments.
    func arguments() -> [String]
}

/// Describes a Terminal command.
class Command: NSObject {
    
    var name: String
    var arguments: [String]?
    
    /// Custom initializer.
    ///
    /// - Parameter name: Name of UNIX executable.
    init(withExecutable executable: CommandExecutable) {
        self.name = executable.rawValue
    }
}
