//
//  GarageDoorStatus.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 2.9.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct GarageDoorStatus : Identifiable {
    var id = UUID()
    var dist, door, vehicle, rcnt: Int
    var fwv: String
    var name, mac: String
    var cid, rssi: Int
    var doorStatus: String
    var vehicleStatus: String
    var statusImage: String
    var cmdButton: String
    var cmdText: String

    static let DoorOpenImage = "GarageDoorOpen"
    static let DoorShutImage = "GarageDoorShut"
    
    init(dist:Int? = nil,
         door:Int? = nil,
         vehicle:Int? = nil,
         rcnt:Int? = nil,
         fwv:String? = nil,
         name:String? = nil,
         mac:String? = nil,
         cid:Int? = nil,
         rssi:Int? = nil)
    {
        self.dist    = dist ?? 0
        self.door    = door ?? 0
        self.vehicle = vehicle ?? 0
        self.rcnt    = rcnt ?? 0
        self.fwv     = fwv ?? ""
        self.name    = name ?? ""
        self.mac     = mac ?? ""
        self.cid     = cid ?? 0
        self.rssi    = rssi ?? 0
        self.doorStatus = self.door == 0 ? "Closed" : "Open  "
        self.vehicleStatus = self.vehicle == 0 ? "Absent" : "Present"
        self.statusImage = self.door == 0 ? GarageDoorStatus.DoorShutImage : GarageDoorStatus.DoorOpenImage
        self.cmdButton = self.door == 0 ? "lock.open" : "lock"
        self.cmdText = self.door == 0 ? "Open" : "Close"
    }
}

#if DEBUG
let testStatus = GarageDoorStatus()
#endif
