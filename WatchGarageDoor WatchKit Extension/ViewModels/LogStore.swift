//
//  LogStore.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 25.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//
//  Please, see OpenGarage firmware API documentation at https://github.com/OpenGarage/OpenGarage-Firmware docs/OGAPI1.2.3.pdf
//

import SwiftUI
import Combine

class LogStore : ObservableObject {

    @Published var doorLog: [GarageDoorLog] = []
    @Published var changeStatus: ResultModel = ResultModel()
    
    /// Read device status log using Web Service
    /// - Parameters:
    ///   - url: URL of the device
    ///   - logRows: Maximum number of log entries to fetch into doorLog
    func fetch(url: URL, logRows: Int) {

        #if DEBUG
        print("Get Log: \(url.absoluteString)")
        #endif

        let showLogService = ServiceRequest.showLog
        let request = RequestObject(method: "GET", path: url.absoluteString, params: nil, service: showLogService, log: false)    
        var log = FormattedLog(name: nil, time: nil, logs: nil)
        
        self.doorLog.removeAll()
        
        WebService(requestObject: request).decoded(Log.self,
                                                   completion: { response in
                                                    switch response
                                                    {
                                                    case .success(let items):
                                                        DispatchQueue.main.async {
                                                            self.changeStatus.error = false
                                                            self.changeStatus.alert = ""
                                                                
                                                            // Build the formatted log
                                                            log.name = items.name
                                                            log.time = getDate(unixdate: items.time)
                                                            
                                                            let sortedLog = items.logs.sorted {
                                                                $0[0] > $1[0]
                                                            }
                                                            sortedLog.forEach {
                                                                let timeStamp = getDate(unixdate: $0[0])
                                                                let doorStatus = DoorStatus(rawValue: $0[1])! == DoorStatus.closed ? "Closed" : "Open  "
                                                                let distanceVal = $0[2]
                                                                let logEntry = LogEntry(doorStatus: doorStatus, timeStamp: timeStamp, distanceMM: distanceVal)
                                                                log.logs.append(logEntry)
                                                            }
                                                            
                                                            // Keep most recent records upto configured log row count
//                                                            let logRows = self.deviceList.getLogRows()
                                                            if(log.logs.count > logRows) {
                                                                let removeCount = log.logs.count - logRows
                                                                log.logs.removeLast(removeCount)
                                                            }
                                                            
                                                            log.logs.forEach {
                                                                let imageName = $0.doorStatus == "Closed" ? GarageDoorStatus.DoorShutImage : GarageDoorStatus.DoorOpenImage
                                                                let logEntry = GarageDoorLog(doorStatus: $0.doorStatus, timeStamp: $0.timeStamp, distanceMM: String($0.distanceMM), imageName: imageName)
                                                                self.doorLog.append(logEntry)
                                                            }
                                                            
                                                        }
                                                        
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
