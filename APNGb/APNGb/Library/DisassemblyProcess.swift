//
//  DisassemblyProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/20/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class DisassemblyProcess: ExecutableProcess {
    
    private let workingAnimatedImageName = "workingAnimatedImage.png"
    
    override init(withCommand command: Command, andAdditionalData additionalData: Any? = nil) {
        DirectoryManager.shared.createWorkingDirectory(forCommandExecutable: .disassembly)

        if let animatedImagePath = command.arguments?[0] {
            let animatedImageUrl = URL(fileURLWithPath: animatedImagePath)
            let animatedImageNewUrl = DirectoryManager.shared.createUrlForFile(withName: workingAnimatedImageName,
                                                                               forCommandExecutable: .disassembly)

            if let animatedImageNewUrl = animatedImageNewUrl {
                // Update argument value which holds path to animated image. This is required because animated image
                // will be copied to a temporary folder, where frames will also reside.
                command.arguments?[0] = animatedImageNewUrl.path
                
                DirectoryManager.shared.copyFilesInWorkingDirectory(forCommandExecutable: .disassembly,
                                                                    atPaths: [animatedImageUrl],
                                                                    toPath: [animatedImageNewUrl])
                
            } else {
                debugPrint("\(#function): Animated image url from temporary directory is nil. Disassemblig will fail.")
            }
            
        } else {
            debugPrint("\(#function): Arguments array doesn't contain path to the animated image. Disassembling will fail.")
        }
    
        super.init(withCommand: command)
    }
    
    override func cleanup() {
         DirectoryManager.shared.cleanupWorkingDirectory(forCommandExecutable: .disassembly)
    }
    
    override func didFinishedWithSuccess(success: Bool, url: URL?) {
        
        if success {
            DirectoryManager.shared.moveFiles(forCommandExecutable: .disassembly,
                                              toPath: url!,
                                              withNames: [self.workingAnimatedImageName],
                                              toIgnore: false)
        }
        
        self.cleanup()
    }
}
