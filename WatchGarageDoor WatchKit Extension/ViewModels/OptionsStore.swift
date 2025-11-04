//
//  OptionsStore.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 27.4.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware docs/OGAPI1.2.3.pdf
//

import SwiftUI
import Combine

class OptionsStore : ObservableObject {
    
    @Published var doorOptions = GarageDoorOptions()
    @Published var changeStatus: ResultModel = ResultModel()
    
    /// Read device options from Web Service
    /// - Parameter url: URL of the device
    func fetch(url: URL) {
        
        #if DEBUG
        print(url.absoluteString)
        print("Get Options")
        #endif
        
        let service = ServiceRequest.getOptions
        let request = RequestObject(method: "GET", path: url.absoluteString, params:
            nil, service: service, log: false)
        
        // Get controller options
        WebService (requestObject: request).decoded(Options.self,
                                                    completion: { response in
                                                        switch response
                                                        {
                                                        case .success(let opts):
                                                            DispatchQueue.main.async {
                                                                self.changeStatus.error = false
                                                                self.changeStatus.alert = ""
                                                                
                                                                self.doorOptions.fwv  = opts.fwv
                                                                self.doorOptions.sn1  = opts.sn1 ?? 0
                                                                self.doorOptions.sn2  = opts.sn2 ?? 0
                                                                self.doorOptions.sno  = opts.sno ?? 0
                                                                self.doorOptions.dth  = opts.dth
                                                                self.doorOptions.vth  = opts.vth
                                                                self.doorOptions.riv  = opts.riv
                                                                self.doorOptions.alm  = opts.alm
                                                                self.doorOptions.aoo  = opts.aoo
                                                                self.doorOptions.lsz  = opts.lsz
                                                                self.doorOptions.tsn  = opts.tsn
                                                                self.doorOptions.htp  = opts.htp
                                                                self.doorOptions.cdt  = opts.cdt
                                                                self.doorOptions.dri  = opts.dri
                                                                self.doorOptions.sfi  = opts.sfi ?? 0
                                                                self.doorOptions.cmr  = opts.cmr ?? 0
                                                                self.doorOptions.sto  = opts.sto
                                                                self.doorOptions.ati  = opts.ati
                                                                self.doorOptions.ato  = opts.ato
                                                                self.doorOptions.atib = opts.atib
                                                                self.doorOptions.atob = opts.atob
                                                                self.doorOptions.noto = opts.noto
                                                                self.doorOptions.usi  = opts.usi
                                                                self.doorOptions.cld  = opts.cld ?? 0
                                                                self.doorOptions.ssid = String(opts.ssid)
                                                                self.doorOptions.auth = String(opts.auth)
                                                                self.doorOptions.bdmn = String(opts.bdmn)
                                                                self.doorOptions.bprt = opts.bprt
                                                                self.doorOptions.name = String(opts.name)
                                                                self.doorOptions.iftt = String(opts.iftt)
                                                                self.doorOptions.mqen = opts.mqen ?? 0
                                                                self.doorOptions.mqtt = String(opts.mqtt)
                                                                self.doorOptions.mqpt = opts.mqpt ?? 0
                                                                self.doorOptions.mqur = opts.mqur ?? ""
                                                                self.doorOptions.mqtp = opts.mqtp ?? ""
                                                                self.doorOptions.emen = opts.emen ?? 0
                                                                self.doorOptions.smtp = opts.smtp ?? ""
                                                                self.doorOptions.sprt = opts.sprt ?? 0
                                                                self.doorOptions.send = opts.send ?? ""
                                                                self.doorOptions.recp = opts.recp ?? ""
                                                                self.doorOptions.ntp1 = opts.ntp1 ?? ""
                                                                self.doorOptions.host = opts.host ?? ""
                                                                self.doorOptions.dvip = String(opts.dvip)
                                                                self.doorOptions.gwip = String(opts.gwip)
                                                                self.doorOptions.subn = String(opts.subn)
                                                                self.doorOptions.dns1 = String(opts.dns1)
                                                                
                                                            }
                                                            break
                                                            
                                                        case .failure(let error):
                                                            DispatchQueue.main.async {
                                                                #if DEBUG
                                                                // print(error)
                                                                #endif
                                                                self.changeStatus.error = true
                                                                self.changeStatus.alert = ErrorDesc(error: error)
                                                                
                                                            }
                                                        }
        })
        
        
    }
}
