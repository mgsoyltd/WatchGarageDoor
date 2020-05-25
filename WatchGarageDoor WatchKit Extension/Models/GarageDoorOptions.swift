//
//  GarageDoorOptions.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 27.4.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct GarageDoorOptions : Identifiable {
    
    var id = UUID()
    var fwv, mnt, dth, vth, riv, alm, aoo: Int
    var lsz, tsn, htp, cdt, dri, sto, mod: Int
    var ati, ato, atib, atob, noto, usi: Int
    var ssid, auth, bdmn: String
    var bprt: Int
    var name, iftt, mqtt, dvip, gwip, subn, dns1: String
    
    init(
        fwv:Int?     = nil,
        mnt:Int?     = nil,
        dth:Int?     = nil,
        vth:Int?     = nil,
        riv:Int?     = nil,
        alm:Int?     = nil,
        aoo:Int?     = nil,
        lsz:Int?     = nil,
        tsn:Int?     = nil,
        htp:Int?     = nil,
        cdt:Int?     = nil,
        dri:Int?     = nil,
        sto:Int?     = nil,
        mod:Int?     = nil,
        ati:Int?     = nil,
        ato:Int?     = nil,
        atib:Int?    = nil,
        atob:Int?    = nil,
        noto:Int?    = nil,
        usi:Int?     = nil,
        ssid:String? = nil,
        auth:String? = nil,
        bdmn:String? = nil,
        bprt:Int?    = nil,
        name:String? = nil,
        iftt:String? = nil,
        mqtt:String? = nil,
        dvip:String? = nil,
        gwip:String? = nil,
        subn:String? = nil,
        dns1:String? = nil
    )
    {
        self.fwv  = fwv  ?? 0
        self.mnt  = mnt  ?? 0
        self.dth  = dth  ?? 0
        self.vth  = vth  ?? 0
        self.riv  = riv  ?? 0
        self.alm  = alm  ?? 0
        self.aoo  = aoo  ?? 0
        self.lsz  = lsz  ?? 0
        self.tsn  = tsn  ?? 0
        self.htp  = htp  ?? 0
        self.cdt  = cdt  ?? 0
        self.dri  = dri  ?? 0
        self.sto  = sto  ?? 0
        self.mod  = mod  ?? 0
        self.ati  = ati  ?? 0
        self.ato  = ato  ?? 0
        self.atib = atib ?? 0
        self.atob = atob ?? 0
        self.noto = noto ?? 0
        self.usi  = usi  ?? 0
        self.ssid = ssid ?? ""
        self.auth = auth ?? ""
        self.bdmn = bdmn ?? ""
        self.bprt = bprt ?? 0
        self.name = name ?? ""
        self.iftt = iftt ?? ""
        self.mqtt = mqtt ?? ""
        self.dvip = dvip ?? ""
        self.gwip = gwip ?? ""
        self.subn = subn ?? ""
        self.dns1 = dns1 ?? ""
    }
    
}

#if DEBUG
let testOptions = GarageDoorOptions()
#endif
