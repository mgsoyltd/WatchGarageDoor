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
    
    
    //    func sliceByCharacter(from: Character, to: Character) -> String? {
    //        let fromIndex = self.index(self.firstIndex(of: from)!, offsetBy: 1)
    //        let toIndex = self.index(self.firstIndex(of: to)!, offsetBy: -1)
    //        return String(self[fromIndex...toIndex])
    //    }
    //
    //    func sliceByString(from:String, to:String) -> String? {
    //        //From - startIndex
    //        if let range = self.range(of: from) {
    //            let subString = String(self[range.upperBound...])
    //            //To - endIndex
    //            if let range2 = subString.range(of: to) {
    //                return String(subString[..<range2.lowerBound])
    //            }
    //        }
    //        return nil
    //    }
    //
    //    func sliceByWord(from:String) -> String? {
    //        //From - startIndex
    //        if let range = self.range(of: from) {
    //            return String(self[range.upperBound...])
    //        }
    //        return nil
    //    }
    //
    //    // LEFT
    //    // Returns the specified number of chars from the left of the string
    //    // let str = "Hello"
    //    // print(str.left(3))         // Hel
    //    func left(_ to: Int) -> String {
    //        return "\(self[..<self.index(startIndex, offsetBy: to)])"
    //    }
    //
    //    // RIGHT
    //    // Returns the specified number of chars from the right of the string
    //    // let str = "Hello"
    //    // print(str.right(3))         // llo
    //    func right(_ from: Int) -> String {
    //        return "\(self[self.index(startIndex, offsetBy: self.count-from)...])"
    //    }
    //
    //    // MID
    //    // Returns the specified number of chars from the startpoint of the string
    //    // let str = "Hello"
    //    // print(str.mid(2,amount: 2))         // ll
    //    func mid(_ from: Int, amount: Int) -> String {
    //        let x = "\(self[self.index(startIndex, offsetBy: from)...])"
    //        return x.left(amount)
    //    }
    //
    //    func toDate(withFormat format: String = "dd.MM.yyyy") -> Date? {
    //
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.timeZone = TimeZone(identifier: "Finnish")
    //        dateFormatter.locale = Locale(identifier: "fi-FI")
    //        dateFormatter.calendar = Calendar(identifier: .gregorian)
    //        dateFormatter.dateFormat = format
    //        let date = dateFormatter.date(from: self)
    //
    //        return date
    //    }
}
