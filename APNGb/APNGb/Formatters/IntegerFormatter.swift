//
//  IntegerFormatter.swift
//  APNGbPro
//
//  Created by Stefan Godoroja on 1/18/17.
//  Copyright © 2017 Godoroja Stefan. All rights reserved.
//

import Cocoa

extension String {
    
    func isInt() -> Bool {
        
        if let intValue = Int(self) {
            
            if intValue >= 0 {
                return true
            }
        }
        
        return false
    }
    
    func numberOfCharacters() -> Int {
        return self.characters.count
    }
}

final class IntegerFormatter: NumberFormatter {

    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        // Allow blank value
        if partialString.numberOfCharacters() == 0  {
            return true
        }
        
        // Validate string if it's an int
        if partialString.isInt() {
            return true
        } else {
            NSBeep()
            return false
        }
    }
}
