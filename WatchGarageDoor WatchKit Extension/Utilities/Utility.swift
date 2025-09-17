//
//  Utility.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 24.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import Foundation

/**
 *
 * Convert unix time to human readable time. Return empty string if unixtime
 * argument is 0.
 *
 * @param unixdate the time in unix format, e.g. 1482505225
 * @return the date and time converted into human readable String format
 *
 **/

public func getDate(unixdate: Int) -> String {
    if unixdate == 0 {return ""}
    let date = NSDate(timeIntervalSince1970: TimeInterval(unixdate))
    let dayTimePeriodFormatter = DateFormatter()
//    dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    dayTimePeriodFormatter.dateStyle = .short
    dayTimePeriodFormatter.timeStyle = .medium
    dayTimePeriodFormatter.timeZone  = .current
    dayTimePeriodFormatter.locale    = .current
    #if DEBUG
//    print("Current Locale:")
//    print(dayTimePeriodFormatter.locale ?? "Invalid locale!")
    #endif
    let locale = Locale.current
    if (locale.region?.identifier == nil || locale.region?.identifier == "") {
        let userLanguages = Locale.preferredLanguages
        #if DEBUG
//        print("User preferred lingos", userLanguages)
        #endif
        if (userLanguages.count > 1) {
            for region in userLanguages {
                let components = region.components(separatedBy: "-")
                if (components.count == 2) {
                    let country = components[1]
                    if let lingo = locale.language.languageCode?.identifier {
                        let locale_str = "\(lingo)_\(country)"
                        dayTimePeriodFormatter.locale = Locale(identifier: locale_str)
                        #if DEBUG
//                        print("Locale changed to:")
//                        print(dayTimePeriodFormatter.locale ?? "Invalid locale! \(locale_str)")
                        #endif
                    }
                }
            }
        }
    }
// Just for testingdate formatting in different regions
//    dayTimePeriodFormatter.locale = Locale(identifier: "fi_FI")
//    dayTimePeriodFormatter.locale = Locale(identifier: "en_US")
//    dayTimePeriodFormatter.locale = Locale(identifier: "fr_FR")
//    dayTimePeriodFormatter.locale = Locale(identifier: "de_DE")
//    dayTimePeriodFormatter.locale = Locale(identifier: "en_GB")
//    dayTimePeriodFormatter.locale = Locale(identifier: "ja_JP")
//    #if DEBUG
//    print("Changed Locale:")
//    print(dayTimePeriodFormatter.locale!)
//    #endif
    
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

protocol OptionalType {
    var customUnwrapped: Any { get }
    var customFlattened: Any { get }
}

extension Optional: OptionalType {
    var customUnwrapped: Any {
        if let value = self {
            return value
        }
        fatalError("Found nil while unwrapping Optional")
    }
    var customFlattened: Any { return (self.customUnwrapped as? OptionalType)?.customFlattened ?? self.customUnwrapped }
}

public func stringFromAny(_ value:Any?) -> String {
    switch value {
    case .some(let wrapped):
        if let notNil =  wrapped as? OptionalType, !(notNil.customFlattened is NSNull) {
            return String(describing: notNil.customFlattened)
        } else if !(wrapped is OptionalType) {
            return String(describing: wrapped)
        }
        return ""
    case .none :
        return ""
    }
}

public func ErrorDesc(error: ServiceError) -> String {
    
    guard !String(describing: error).isEmpty else {
        return ("")
    }
    let str = String(describing: error)
    // Create a CharacterSet of delimiters
    let separators = CharacterSet(charactersIn: "()")
    // Split based on characters
    let components = str.components(separatedBy: separators)
    let desc = components.dropFirst().first!.filter { $0 != "\"" }
    return (desc)
}

