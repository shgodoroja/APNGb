//
//  DirectoryManager.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/21/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

class DirectoryManager {
    
    static let shared = DirectoryManager()
    
    private init() {}
    
    func cleanupWorkingDirectory(forCommandExecutable executable: CommandExecutable) {
        let directoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        
        if let directoryUrl = directoryUrl {
            _ = FileManager.default.removeItemIfExists(atPath: directoryUrl.path)
        }
    }
    
    func moveFiles(forCommandExecutable executable: CommandExecutable,
                   toPath destinationUrl: URL,
                   withNames fileNames: [String],
                   toIgnore ignore: Bool) {
        
        let directoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directoryUrl!,
                                                                    includingPropertiesForKeys: nil,
                                                                    options: .skipsHiddenFiles)
            for fileUrl in files {
                let fileName = fileUrl.lastPathComponent
                let fileExtension = fileUrl.pathExtension
                
                if fileNames.contains(fileName) == ignore && fileExtension != FileExtension.txt {
                    let updatedDestinationUrl = destinationUrl.appendingPathComponent(fileName)
                    try _ = FileManager.default.replaceItemAt(updatedDestinationUrl,
                                                              withItemAt: fileUrl)
                }
            }
            
        } catch let error {
            NSLog("\(#function): \(error)")
        }
    }
    
    func copyFilesInWorkingDirectory(forCommandExecutable executable: CommandExecutable, atPaths sourceUrls: [URL], toPath destinationUrls: [URL]) {
        let bound = sourceUrls.count
        
        for index in stride(from: 0, to: bound, by: 1) {
            copyFile(atPath: sourceUrls[index],
                     toPath: destinationUrls[index])
        }
    }
    
    func createUrlForFile(withName name: String, forCommandExecutable executable: CommandExecutable) -> URL? {
        let workingDirectoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        return workingDirectoryUrl?.appendingPathComponent(name)
    }
    
    func workingDirectoryUrl(forCommandExecutable executable: CommandExecutable) -> URL? {
        let temporaryDirectoryUrl = NSURL(fileURLWithPath: NSTemporaryDirectory())
        let mainDirectoryUrl = temporaryDirectoryUrl.appendingPathComponent(Resource.Directory.main)
        var destinationDirectoryUrl: URL? = nil
        
        switch executable {
        case .assembly:
            destinationDirectoryUrl = mainDirectoryUrl?.appendingPathComponent(Resource.Directory.assembly)
        case .disassembly:
            destinationDirectoryUrl = mainDirectoryUrl?.appendingPathComponent(Resource.Directory.disassembly)
        default:
            destinationDirectoryUrl = nil
        }
        
        return destinationDirectoryUrl
    }
    
    func createWorkingDirectory(forCommandExecutable executable: CommandExecutable) {
        let directoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        
        if let directoryUrl = directoryUrl {
            let directoryWasRemoved = FileManager.default.removeItemIfExists(atPath: directoryUrl.path)
            
            if directoryWasRemoved {
                do {
                    try FileManager.default.createDirectory(at: directoryUrl,
                                                            withIntermediateDirectories: true,
                                                            attributes: nil)
                    #if DEBUG
                        NSWorkspace.shared.open(directoryUrl)
                    #endif
                } catch let error {
                    NSLog("\(#function): \(error)")
                }
            }
        }
    }
    
    // MARK: Private
    
    private func copyFile(atPath sourcePath: URL, toPath destinationPath: URL) {
        
        do {
            try FileManager.default.copyItem(atPath: sourcePath.path,
                                             toPath: destinationPath.path)
            
        } catch let error {
            NSLog("\(#function): \(error)")
        }
    }
}
