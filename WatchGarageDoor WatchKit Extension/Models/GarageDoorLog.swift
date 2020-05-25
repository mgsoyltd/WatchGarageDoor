//
//  GarageDoorLog.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 25.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct GarageDoorLog : Identifiable, Codable, Hashable {
    var id = UUID()
    let doorStatus: String
    let timeStamp: String
    let distanceMM: String
    let imageName: String
}

#if DEBUG
let testData = [
    GarageDoorLog(doorStatus: "Closed", timeStamp: "26.08.2019 12:00:05", distanceMM: "189", imageName: "DoorClosed"),
    GarageDoorLog(doorStatus: "Open  ", timeStamp: "26.08.2019 12:00:00", distanceMM: "30", imageName: "DoorOpen")
]
#endif
