//
//  Model.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 18.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware/tree/master/docs
//

import Foundation

enum DoorStatus: Int, Codable {
    case closed
    case open
}

enum VehicleStatus: Int, Codable {
    case absent
    case present
    case unknown
}

struct Log: Decodable {
    let name: String
    let time: Int
    let logs: [[Int]]
}

struct Variables: Decodable {
    let dist, door, vehicle, rcnt: Int
    let fwv: Int
    let name, mac: String
    let cid, rssi: Int
}

struct ChangeVariables: Decodable {
    let result: Int
    let item: String
}

struct Options: Decodable {
    let fwv, mnt, dth, vth: Int
    let riv, alm, aoo, lsz: Int
    let tsn, htp, cdt, dri: Int
    let sto, mod, ati, ato: Int
    let atib, atob, noto, usi: Int
    let ssid, auth, bdmn: String
    let bprt: Int
    let name, iftt, mqtt: String
    let dvip, gwip, subn, dns1: String
}

struct LogEntry {
    let doorStatus: String
    let timeStamp: String
    let distanceMM: Int
    
    init(doorStatus: String?, timeStamp: String?, distanceMM: Int?) {
        self.doorStatus = doorStatus ?? ""
        self.timeStamp = timeStamp ?? ""
        self.distanceMM = distanceMM ?? 0
    }
}

struct FormattedLog {
    var name: String
    var time: String
    var logs: [LogEntry]
    
    init(name: String?, time: String?, logs: [LogEntry]?) {
        self.name = name ?? ""
        self.time = time ?? ""
        self.logs = logs ?? []
    }
}

