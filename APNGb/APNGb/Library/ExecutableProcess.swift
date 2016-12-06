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
    
    private var fileHandle: FileHandle?
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
        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        fileHandle = outputPipe.fileHandleForReading
        fileHandle?.waitForDataInBackgroundAndNotify()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedData(notification:)),
                                               name: NSNotification.Name.NSFileHandleDataAvailable,
                                               object: nil)
    }
    
    func start() {
        task.launch()
    }
    
    func stop() {
        task.terminate()
    }
    
    func receivedData(notification : NSNotification) {
        
        if let fileHandle = fileHandle {
            let data = fileHandle.availableData
            
            if data.count > 0 {
                fileHandle.waitForDataInBackgroundAndNotify()
                let outputString = String(data: data,
                                          encoding: String.Encoding.ascii)
                
                if let outputString = outputString {
                    self.progressHandler?(outputString)
                }
            }
        }
    }
}

