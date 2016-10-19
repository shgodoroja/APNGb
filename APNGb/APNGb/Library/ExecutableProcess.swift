//
//  ExecutableProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class ExecutableProcess: NSObject {
    
    var terminationHandler: VoidHandler
    var progressHandler: ((String) -> ())?
    
    private var task = Process()
    
    init(withCommand command: Command) {
        super.init()
        
        task.launchPath = Bundle.main.path(forResource: command.name, ofType: nil)
        task.arguments = command.arguments
        task.terminationHandler = { process in
            
            if let handler = self.terminationHandler {
                DispatchQueue.main.async(execute: {
                    handler()
                })
            }
        }
    }
    
    func start() {
        task.launch()
    }
    
    func stop() {
        task.terminate()
    }
}
