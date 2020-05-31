//
//  Config.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 11.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI
import Combine


final class Config : ObservableObject {
    
    public var didChange = PassthroughSubject<Config, Never>()
    
//    // For displaying the Welcome screen
//    @Configuration(key: "firstLaunch", defaultValue: Date())
//    var firstLaunch: Date {
//        didSet {
//            self.didChange.send(self)
//        }
//    }
//
//    // For displaying the Welcome screen
//    @Configuration(key: "lastVersion", defaultValue: String())
//    var lastVersion: String {
//        didSet {
//            self.didChange.send(self)
//        }
//    }
    
    // For displaying more info per device on the device list
    @Configuration(key: "showInfoOnList", defaultValue: true)
    var showInfoOnList: Bool {
        didSet {
            self.didChange.send(self)
        }
    }
    
    // Array of device objects
    @Configuration(key: "Devices", defaultValue: [DeviceModel]())
    var deviceList: [DeviceModel] {
        didSet {
            self.didChange.send(self)
        }
        willSet {
            self.didChange.send(self)
        }
    }
        
    func newDevice() -> Int {
        let newDevice = DeviceModel(name: "New device")
        deviceList.append(newDevice)
        objectWillChange.send()
        return deviceList.count-1
    }
    
    func deleteDevices(_ idxSet: IndexSet) {
        self.deviceList.remove(atOffsets: idxSet)
        objectWillChange.send()
    }
    
    func moveDevice(from source: IndexSet, to destination: Int) {
        self.deviceList.move(fromOffsets: source, toOffset: destination)
        objectWillChange.send()
    }
    
}
