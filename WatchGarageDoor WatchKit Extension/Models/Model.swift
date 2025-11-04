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
    let ncols: Int?         // number of columns (3 or 4, depending on if sn2_value is attached) - optional for backward compatibility
    let logs: [[Int]]       // array of log entries [time_stamp, door_status, distance_value, sn2_value]
                            // sn2_value is included if ncols == 4
}

struct Variables: Decodable {
    let dist, door, vehicle, rcnt: Int
    let fwv: Int
    let name, mac: String
    let cid, rssi: Int
    let sn2: Int?           // switch sensor value (optional, only if switch sensor is enabled)
    let cld: Int?           // cloud option (0:none; 1:Blynk; 2:OTC) - optional for backward compatibility
    let clds: Int?          // cloud connection status - optional for backward compatibility
    let temp: Double?       // temperature reading in Celsius (optional, only if T/H sensor is enabled)
    let humid: Double?      // humidity reading in percentage (optional, only if T/H sensor is enabled)
}

struct ChangeVariables: Decodable {
    let result: Int
    let item: String
}

struct Options: Decodable {
    let fwv: Int
    let sn1: Int?           // sn1 (distance sensor) mounting type (0: ceiling mount; 1: side mount)
    let sn2: Int?           // sn2 (switch sensor) type (0: none; 1: normally closed; 2: normally open)
    let sno: Int?           // sensor logic (0: use sn1 only; 1: sn2 only; 2: sn1 AND sn2; 3: sn1 OR sn2)
    let dth, vth: Int
    let riv, alm, aoo, lsz: Int
    let tsn, htp, cdt, dri: Int
    let sfi: Int?           // sensor filtering method (0: median; 1: consensus)
    let cmr: Int?           // consensus margin for consensus method (unit: cm)
    let sto: Int
    let ati, ato: Int
    let atib, atob, noto, usi: Int
    let cld: Int?           // cloud connection option (0:none; 1:Blynk; 2:OTC)
    let ssid, auth, bdmn: String
    let bprt: Int
    let name, iftt: String
    let mqen: Int?          // mqtt enable (0:disable; 1:enable)
    let mqtt: String
    let mqpt: Int?          // mqtt port
    let mqur: String?       // mqtt server user name
    let mqtp: String?       // mqtt topic
    let emen: Int?          // email enable
    let smtp: String?       // smtp server name
    let sprt: Int?          // smtp server port
    let send: String?       // email sender
    let recp: String?       // recipient email
    let ntp1: String?       // NTP server url
    let host: String?       // Custom Host name
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

