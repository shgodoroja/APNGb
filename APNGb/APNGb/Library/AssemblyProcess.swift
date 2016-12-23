//
//  AssemblyProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/20/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

final class AssemblyProcess: ExecutableProcess {
    
    private let generatedAnimatedImageName = "apngb-animated.png"
    
    override init(withCommand command: Command, andAdditionalData additionalData: Any? = nil) {
        DirectoryManager.shared.createWorkingDirectory(forCommandExecutable: .assembly)
        let animatedImageNewUrl = DirectoryManager.shared.createUrlForFile(withName: generatedAnimatedImageName,
                                                                           forCommandExecutable: .assembly)
        if let animatedImageNewUrl = animatedImageNewUrl {
            // Insert path to temporary folder where animated image created from frames will reside.
            command.arguments?.insert(animatedImageNewUrl.path, at: 0)
            
            // Copy frames in assembly folder.
            var sourceUrls: [URL] = []
            var destinationUrls: [URL] = []
            let frameName = command.arguments![1]
            let imageFrames = additionalData as! [AnimationFrame]
            let workingDirectory = DirectoryManager.shared.workingDirectoryUrl(forCommandExecutable: .assembly)
            
            var frameIndex = 0
            for frame in imageFrames {
                sourceUrls.append(URL(fileURLWithPath: frame.path))
                
                let fileNameWithoutExtension = frameName + "\(frameIndex)" + String.dot
                let imageName = fileNameWithoutExtension + FileExtension.png
                let destinationUrl = workingDirectory?.appendingPathComponent(imageName)
                destinationUrls.append(destinationUrl!)
                
                let textFileName = fileNameWithoutExtension + FileExtension.txt
                let textFilePath = workingDirectory?.appendingPathComponent(textFileName).path
                let contentWithDelayValue = "delay=" + frame.displayableFrameDelay
                FileManager.default.createFile(atPath: textFilePath!,
                                               contents: contentWithDelayValue.data(using: .utf8),
                                               attributes: nil)
                frameIndex += 1
            }
            
            // Set path for source image frame argument to be one from temporary directory.
            command.arguments?[1] = destinationUrls[0].path
            
            DirectoryManager.shared.copyFilesInWorkingDirectory(forCommandExecutable: .assembly,
                                                                atPaths: sourceUrls,
                                                                toPath: destinationUrls)
        } else {
            debugPrint("\(#function): Can't create url for animated image which will be created from frames. Assembling will fail.")
        }
        
        super.init(withCommand: command)
    }
    
    override func cleanup() {
        DirectoryManager.shared.cleanupWorkingDirectory(forCommandExecutable: .assembly)
    }
    
    override func didFinishedWithSuccess(success: Bool, url: URL?) {
        
        if success {
            DirectoryManager.shared.moveFiles(forCommandExecutable: .assembly,
                                              toPath: url!,
                                              withNames: [generatedAnimatedImageName],
                                              toIgnore: true)
        }
        
        self.cleanup()
    }
}
