//
//  StatusStore.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 26.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware docs/OGAPI1.1.0.pdf
//

import SwiftUI
import Combine

class StatusStore : ObservableObject {
        
    public var didChange = PassthroughSubject<StatusStore, Never>()
    public var willChange = PassthroughSubject<StatusStore, Never>()
    
    @Published var doorStatus   = GarageDoorStatus()
    @Published var changeStatus = ResultModel()
    
    /// Read the current status of the garage door from Web Service
    /// - Parameter url: URL of the device
    func fetch(url: URL) {
        
        #if DEBUG
        print(url.absoluteString)
        print("Get Variables")
        #endif
        
        let service = ServiceRequest.getVariables
        let request = RequestObject(method: "GET", path: url.absoluteString, params: nil, service: service, log: false)   
        
        // Get controller variables
        WebService (requestObject: request).decoded(Variables.self,
                                                    completion: { response in
                                                        switch response
                                                        {
                                                        case .success(let stat):
                                                            DispatchQueue.main.async {
                                                                self.changeStatus.error = false
                                                                self.changeStatus.alert = ""
                                                                
                                                                self.doorStatus.dist = stat.dist
                                                                self.doorStatus.door = stat.door
                                                                self.doorStatus.vehicle = stat.vehicle
                                                                self.doorStatus.rcnt = stat.rcnt
                                                                self.doorStatus.fwv = String(stat.fwv)
                                                                self.doorStatus.name = stat.name 
                                                                self.doorStatus.mac = stat.mac
                                                                self.doorStatus.cid = stat.cid
                                                                self.doorStatus.rssi = stat.rssi
                                                                self.doorStatus.doorStatus =
                                                                    stat.door == 0 ? "Closed" : "Open  "
                                                                self.doorStatus.vehicleStatus =
                                                                    stat.vehicle == 0 ? "Absent" : "Present"
                                                                self.doorStatus.statusImage =
                                                                    stat.door == 0 ? GarageDoorStatus.DoorShutImage : GarageDoorStatus.DoorOpenImage
                                                                self.doorStatus.cmdButton =
                                                                    stat.door == 0 ? "lock.open" : "lock"
                                                                self.doorStatus.cmdText =
                                                                    stat.door == 0 ? "Open" : "Close"
                                                                
                                                                self.willChange.send(self)
                                                            }
                                                            break
                                                            
                                                        case .failure(let error):
                                                            DispatchQueue.main.async {
                                                                #if DEBUG
//                                                                print(error)
                                                                #endif
                                                                self.changeStatus.error = true
                                                                self.changeStatus.alert = ErrorDesc(error: error)
                                                                
                                                                self.willChange.send(self)
                                                            }
                                                        }
        })
        
        
    }
}
