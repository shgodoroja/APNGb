//
//  Command.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

// INFO:
// General form of a UNIX command is: 
// command [-option(s)] [argument(s)]
//

import Cocoa

class Command: NSObject {
    
    var name: String
    var options: [String]?
    var arguments: [String]?
    
    init(withName name: String) {
        self.name = name
    }
}
