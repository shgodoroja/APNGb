//
//  ExecutableHandler.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

enum ExecutableIdentifier {
    case Assembly, Disassembly
}

final class ExecutableHandler {
    
    private var execIdentifier: ExecutableIdentifier
    
    init(withExecutableIdentifier execIdentifier: ExecutableIdentifier) {
        self.execIdentifier = execIdentifier
    }
}
