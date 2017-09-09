//
//  ExecutableProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

struct ExecutableProcessFactory {
    
    static func createProcess(identifiedBy executable: CommandExecutable,
                              and command: Command) -> ExecutableProcess? {
        switch executable {
        case .assembly:
            return AssemblyProcess(withCommand: command)
        case .disassembly:
            return DisassemblyProcess(withCommand: command)
        default:
            return nil
        }
    }
}

class ExecutableProcess: NSObject {
    
    var initialHandler: (()->())?
    var progressHandler: ((String) -> ())?
    var terminationHandler: (()->())?
    var cancelled = false
    
    private var fileHandle: FileHandle?
    private var task = Process()
    
    init(withCommand command: Command)  {
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
        
        if let handler = self.initialHandler {
            handler()
        }
        
        task.launch()
    }
    
    func stop() {
        task.terminate()
    }
    
    func cleanup() {
        assertionFailure("\(#function) must be implemented in subclass")
    }
    
    func didFinishedWithSuccess(success: Bool, url: URL?) {
        assertionFailure("\(#function) must be implemented in subclass")
    }
    
    // MARK: - Private
    
    @objc private func receivedData(notification : NSNotification) {
        
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

