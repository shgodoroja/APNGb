//
//  Argument.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/24/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

struct Argument {
    
    static let numberOfLoops = "-l"
    static let skipFirstFrame = "-f"
    static let enablePalette = "-kp"
    static let enableColorType = "-kc"
    static let enableZlib = "-z0"
    static let enable7zip = "-z1"
    static let enableZopfli = "-z2"
    static let iteration = "-i"
    static let horizontalStrip = "-hs"
    static let verticalStrip = "-vs"
    static let transparency = "-t"
    static let backgroundColor = "-b"
}

class ArgumentTransformer {
    
    func arguments(fromParameters params: [ParameterProtocol]) -> [String] {
        var arguments = [String]()
        
        for param in params {
            let value = param.getValue()
            
            switch param.getIdentifier() {
                
            case .playbackLoop:
                
                if let value = value {
                    let argument = Argument.numberOfLoops + value
                    arguments.append(argument)
                }
                
            case .playbackSkipFirstFrame:
                
                if value != nil {
                    arguments.append(Argument.skipFirstFrame)
                }
                
            case .optimizationPalette:
                
                if value != nil {
                    arguments.append(Argument.enablePalette)
                }
                
            case .optimizationColorType:
                
                if value != nil {
                    arguments.append(Argument.enableColorType)
                }
                
            case .compressionZlib:
                
                if value != nil {
                    arguments.append(Argument.enableZlib)
                }
                
            case .compression7Zip:
                
                if value != nil {
                    arguments.append(Argument.enable7zip)
                }
                
            case .compressionZopfli:
                
                if value != nil {
                    arguments.append(Argument.enableZopfli)
                }
                
            case .compression7ZipIterations,
                 .compressionZopfliIterations:
                
                if value != nil {
                    arguments.append(Argument.iteration)
                }
                
            default:
                debugPrint("Unhandled case")
            }
            
        }
        
        return arguments
    }
}

