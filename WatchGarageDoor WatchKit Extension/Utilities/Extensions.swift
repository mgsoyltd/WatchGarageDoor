//
//  Extensions.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 22.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import Foundation

// ********************************************************************
//              E X T E N S I O N S
// ********************************************************************

extension String {
    
    func isValidIP() -> Bool {
        let parts = self.components(separatedBy: ".")
        let nums = parts.compactMap { Int($0) }
        return parts.count == 4 && nums.count == 4 && nums.filter { $0 >= 0 && $0 < 256 }.count == 4
    }
    
    // String Extension for grabbing a character at a specific position
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
    
}
