//
//  ResultModel.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 15.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct ResultModel : Identifiable, Codable, Hashable {
    var id = UUID()
    var result: Int
    var item: String
    var error: Bool
    var alert: String

    init(result: Int? = nil,
         item: String? = nil)
    {
        self.result = result ?? 0
        self.item   = item ?? ""
        self.error  = false
        self.alert  = ""
    }
    
}

