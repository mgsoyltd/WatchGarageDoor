//
//  Controller.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 15.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware docs/OGAPI1.1.0.pdf
//
//    Change Controller Variables:
//    http://devip/cc?​dkey​=xxx&​click​=1&​close​=1&​open​=1&​reboot​=1&​apmode=​ 1
//    Parameters​:
//    ● dkey: (required) device key (factory default device key is ​opendoor​)
//    ● click/close/open: (optional) trigger relay click / close door / open door
//    ● reboot/apmode: (optional) reboot device / reset device in AP mode (to reconfigure
//          WiFi settings)
//    Examples​:
//    ● http://devip/cc?dkey=xxx&click=1    trigger relay click (i.e. toggle door)
//    ● http://devip/cc?dkey=xxx&close=1    close door (ignored if the door is already closed)
//    ● http://devip/cc?dkey=xxx&reboot=1   reboot device
//


import SwiftUI
import Combine

class Controller : ObservableObject {

    @Published var changeStatus: ResultModel = ResultModel()
    
    func send(url: URL, args: String) {
        // Send change request

        #if DEBUG
        print(url.absoluteString)
        print("Change Variables")
        #endif
        
        let service = ServiceRequest.changeVariables
        let parms = ["args" : args ]
        let request = RequestObject(method: "GET", path: url.absoluteString, params:
            parms, service: service, log: true)
        
        // Change controller variable
        WebService (requestObject: request).decoded(ChangeVariables.self,
                                                    completion: { response in
                                                        switch response
                                                        {
                                                        case .success(let stat):
                                                            DispatchQueue.main.async {
                                                                self.changeStatus.result = stat.result
                                                                self.changeStatus.item = stat.item
                                                                self.changeStatus.error = false
                                                                self.changeStatus.alert = ""
                                                                
                                                            }
                                                            break
                                                            
                                                        case .failure(let error):
                                                            DispatchQueue.main.async {
                                                                self.changeStatus.error = true
                                                                self.changeStatus.alert = ErrorDesc(error: error)
                                                                
                                                            }
                                                            break
                                                        }
        })
    }
    
}


