//
//  DisassemblyProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/20/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class DisassemblyProcess: ExecutableProcess {
    
    private let workingAnimationFile = "WorkingAnimationFile77.png"
    
    override init(withCommand command: Command) {
        DirectoryManager.shared.createWorkingDirectory(forCommandExecutable: .disassembly)

        if let animatedImagePath = command.arguments?[0] {
            let animatedImageUrl = URL(fileURLWithPath: animatedImagePath)
            let newAnimatedImageUrl = DirectoryManager.shared.createUrlForFile(withName: workingAnimationFile,
                                                                               forCommandExecutable: .disassembly)
            
            if let newAnimatedImageUrl = newAnimatedImageUrl {
                DirectoryManager.shared.copyFilesInWorkingDirectory(forCommandExecutable: .disassembly,
                                                                    atPaths: [animatedImageUrl],
                                                                    toPath: newAnimatedImageUrl)
                command.arguments?[0] = newAnimatedImageUrl.path
            } else {
                debugPrint("\(#function): Animated image url from temporary directory is nil. Disassemblig will fail.")
            }
            
        } else {
            debugPrint("\(#function): Arguments array doesn't contain path to the animated image. Disassembling will fail.")
        }
    
        super.init(withCommand: command)
    }
    
    func showFrom(window: NSWindow) {
        let openPanel = NSOpenPanel()
        openPanel.message = Resource.String.selectFolderToSaveFrames
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.beginSheetModal(for: window,
                              completionHandler: { response in
                                
                                if response == NSFileHandlingPanelOKButton {
                                    let destinationDirectoryUrl = openPanel.urls[0]
                                    DirectoryManager.shared.moveFiles(forCommandExecutable: .disassembly,
                                                                      toPath: destinationDirectoryUrl,
                                                                      ignoringFiles: [self.workingAnimationFile])
                                }
                                
                                DirectoryManager.shared.cleanupWorkingDirectory(forCommandExecutable: .disassembly)
        })
    }
}
