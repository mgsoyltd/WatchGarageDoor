//
//  DeviceModel.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 12.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI
import Combine

struct DeviceModel : Identifiable, Codable, Hashable {
    
    var id = UUID()
    var name: String
    var IP: String
    var Port: String
    var Key: String
    var LogRowIdx: Int
    var MaxLogRows: Int = 100
    var LogRowsPickList = [String]()
    
    
    init(name:    String? = nil,
         IP:      String? = nil,
         Port:    String? = nil,
         Key:     String? = nil,
         LogRowIdx:  Int?  = nil,
         MaxLogRows: Int? = nil) {
        
        self.name = name ?? "OpenGarage"
        self.IP = IP ?? "127.0.0.1"
        self.Port = Port ?? "80"
        self.Key = Key ?? ""
        self.LogRowIdx = LogRowIdx ?? 2     // 0-based arrray index i.e. 30 entries
        if let maxLog = MaxLogRows {
            self.MaxLogRows = maxLog        // From device Options parm "lsz"
            if self.MaxLogRows < 10 {
                self.MaxLogRows = 10
            }
        }
        self.LogRowsPickList = self.getPickList()
    }
    
    func getURL() -> URL {
        
        var url: URL
        var resourceString = "http://\(self.IP)"
        if (self.Port != "") {
            resourceString = resourceString + ":\(self.Port)"
        }

        guard let resourceUrl = URL(string: resourceString) else {
            preconditionFailure("Invalid static URL string: \(resourceString)")
        }
        url = resourceUrl
        
        return url
    }
    
    func getDevKey() -> String {
        return self.Key
    }

    func getLogRows() -> Int {
        if (self.LogRowIdx < 10) {
            return (self.LogRowIdx + 1) * 10   // Calculate Number of entries from the value list index
        }
        else {
            return 10
        }
    }
    
    func getPickList() -> [String] {
        var step, max: Int
        var list = [String]()
        max = self.MaxLogRows / 10
        for index in 1...max {
            step = index * 10
            if step <= self.MaxLogRows {
                list.append(String(step))
            }
        }
        #if DEBUG
        print("Picklist: \(list)")
        #endif
        return list
    }
}

