//
//  GarageDoorOptions.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 27.4.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware docs/OGAPI1.2.3.pdf
//

import SwiftUI

struct GarageDoorOptions : Identifiable {

    var id = UUID()
    var fwv: Int
    var sn1, sn2, sno: Int              // sensor configuration
    var dth, vth, riv, alm, aoo: Int
    var lsz, tsn, htp, cdt, dri: Int
    var sfi, cmr: Int                   // sensor filtering
    var sto: Int
    var ati, ato, atib, atob, noto, usi: Int
    var cld: Int                        // cloud connection option
    var ssid, auth, bdmn: String
    var bprt: Int
    var name, iftt: String
    var mqen: Int                       // mqtt enable
    var mqtt: String
    var mqpt: Int                       // mqtt port
    var mqur: String                    // mqtt username
    var mqtp: String                    // mqtt topic
    var emen: Int                       // email enable
    var smtp: String                    // smtp server
    var sprt: Int                       // smtp port
    var send: String                    // email sender
    var recp: String                    // recipient email
    var ntp1: String                    // NTP server
    var host: String                    // custom hostname
    var dvip, gwip, subn, dns1: String

    init(
        fwv:Int?     = nil,
        sn1:Int?     = nil,
        sn2:Int?     = nil,
        sno:Int?     = nil,
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
        sfi:Int?     = nil,
        cmr:Int?     = nil,
        sto:Int?     = nil,
        ati:Int?     = nil,
        ato:Int?     = nil,
        atib:Int?    = nil,
        atob:Int?    = nil,
        noto:Int?    = nil,
        usi:Int?     = nil,
        cld:Int?     = nil,
        ssid:String? = nil,
        auth:String? = nil,
        bdmn:String? = nil,
        bprt:Int?    = nil,
        name:String? = nil,
        iftt:String? = nil,
        mqen:Int?    = nil,
        mqtt:String? = nil,
        mqpt:Int?    = nil,
        mqur:String? = nil,
        mqtp:String? = nil,
        emen:Int?    = nil,
        smtp:String? = nil,
        sprt:Int?    = nil,
        send:String? = nil,
        recp:String? = nil,
        ntp1:String? = nil,
        host:String? = nil,
        dvip:String? = nil,
        gwip:String? = nil,
        subn:String? = nil,
        dns1:String? = nil
    )
    {
        self.fwv  = fwv  ?? 0
        self.sn1  = sn1  ?? 0
        self.sn2  = sn2  ?? 0
        self.sno  = sno  ?? 0
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
        self.sfi  = sfi  ?? 0
        self.cmr  = cmr  ?? 0
        self.sto  = sto  ?? 0
        self.ati  = ati  ?? 0
        self.ato  = ato  ?? 0
        self.atib = atib ?? 0
        self.atob = atob ?? 0
        self.noto = noto ?? 0
        self.usi  = usi  ?? 0
        self.cld  = cld  ?? 0
        self.ssid = ssid ?? ""
        self.auth = auth ?? ""
        self.bdmn = bdmn ?? ""
        self.bprt = bprt ?? 0
        self.name = name ?? ""
        self.iftt = iftt ?? ""
        self.mqen = mqen ?? 0
        self.mqtt = mqtt ?? ""
        self.mqpt = mqpt ?? 0
        self.mqur = mqur ?? ""
        self.mqtp = mqtp ?? ""
        self.emen = emen ?? 0
        self.smtp = smtp ?? ""
        self.sprt = sprt ?? 0
        self.send = send ?? ""
        self.recp = recp ?? ""
        self.ntp1 = ntp1 ?? ""
        self.host = host ?? ""
        self.dvip = dvip ?? ""
        self.gwip = gwip ?? ""
        self.subn = subn ?? ""
        self.dns1 = dns1 ?? ""
    }

}

#if DEBUG
let testOptions = GarageDoorOptions()
#endif
