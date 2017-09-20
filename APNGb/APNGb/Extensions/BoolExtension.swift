//
//  BoolExtension.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/17/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension Bool {
    
    init<T: BinaryInteger>(_ num: T) {
        self.init(num != 0)
    }
}
