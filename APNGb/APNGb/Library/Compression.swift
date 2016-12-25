//
//  Compression.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class Compression: NSObject, CommandArgumentable {
    
    var enableZlib = false {
        
        didSet {
            
            if enableZlib == true {
                enable7zip = false
                enableZopfli = false
            }
        }
    }
    
    var enable7zip = true {
        
        didSet {
            
            if enable7zip == true {
                enableZlib = false
                enableZopfli = false
            }
        }
    }
    
    var enableZopfli = false {
        
        didSet {
            
            if enableZopfli == true {
                enable7zip = false
                enableZlib = false
            }
        }
    }
    
    var sevenZipIterations = 15
    var zopfliIterations = 15
    
    override func setNilValueForKey(_ key: String) {
        
        if key == #keyPath(Compression.sevenZipIterations) {
            sevenZipIterations = 0
        }
        
        if key == #keyPath(Compression.zopfliIterations) {
            zopfliIterations = 0
        }
    }
    
    // MARK: - CommandArgumentable
    
    func havePassedValidation() -> Bool {
        return true
    }
    
    func commandArguments() -> ([String], Any?) {
        var arguments: [String] = []
        
        if enableZlib == true {
            arguments.append(Argument.enableZlib)
        }
        
        if enable7zip == true {
            arguments.append(Argument.enable7zip)
            arguments.append(Argument.iteration + "\(sevenZipIterations)")
        }
        
        if enableZopfli == true {
            arguments.append(Argument.enableZopfli)
            arguments.append(Argument.iteration + "\(zopfliIterations)")
        }
        
        return (arguments, nil)
    }
}
