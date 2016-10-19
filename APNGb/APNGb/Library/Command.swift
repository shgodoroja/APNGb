//
//  Command.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum ExecutableName: String {
    case Assembly = "apngasm", Disassembly = "apngdis"
}

class Command: NSObject {
    
    var name: String
    var arguments: [String]?
    
    init(withExecutableName name: ExecutableName) {
        self.name = name.rawValue
    }
}
