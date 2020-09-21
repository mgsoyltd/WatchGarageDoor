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
    
    public var willChange = PassthroughSubject<Config, Never>()
    public var didChange = PassthroughSubject<Config, Never>()
    
    public var isAppActive = true
    
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
        willSet {
            self.willChange.send(self)
        }
        didSet {
            self.didChange.send(self)
        }
    }
    
    func getDevice(_ id: UUID) -> DeviceModel? {
        if let idx = self.deviceList.firstIndex(where: { $0.id == id }) {
            return self.deviceList[idx]
        }
        return nil
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
