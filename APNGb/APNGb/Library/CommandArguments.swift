//
//  CommandArguments.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/19/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

protocol CommandArguments {
    
    func havePassedValidation() -> Bool
    func commandArguments() -> [String]
    static func defaultArgumentValue() -> String
}

extension CommandArguments {
    
    func havePassedValidation() -> Bool {
        return false
    }
    
    func commandArguments() -> [String] {
        return []
    }
    
    static func defaultArgumentValue() -> String {
        return ""
    }
}
