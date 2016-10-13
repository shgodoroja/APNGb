//
//  ExecutableProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ExecutableProcess: NSObject {
    
    var terminationHandler: (() -> ())?
    var progressHandler: ((String) -> ())?
    
    private var task = Process()
    
    init(withCommand command: Command) {
        super.init()
        
        task.launchPath = pathForFile(withName: command.name)
        task.arguments = command.arguments
        task.terminationHandler = { process in
            
            if let handler = self.terminationHandler {
                DispatchQueue.main.async(execute: {
                    handler()
                })
            }
        }
        
        task.launch()
    }
    
    func start() {
        task.launch()
    }
    
    func stop() {
        task.terminate()
    }
    
    // MARK: Private 
    
    private func pathForFile(withName name: String) ->  String? {
        return Bundle.main.path(forResource: name, ofType: nil)
    }
    
}
