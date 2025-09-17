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
    
    private var appActiveStatus = false
    private var appInactiveStatus = false
    private var appInBackgroundStatus = false
    
    public var appActive       = PassthroughSubject<Config, Never>()
    public var appInactive     = PassthroughSubject<Config, Never>()
    public var appInBackground = PassthroughSubject<Config, Never>()
    
    public var isAppActive: Bool {
        set {
            appActiveStatus = newValue
            self.appActive.send(self)
            #if DEBUG
            print("App is Active")
            #endif
        }
        get {
            return appActiveStatus
        }
    }
    
    public var isAppInactive: Bool {
        set {
            appInactiveStatus = newValue
            self.appInactive.send(self)
            #if DEBUG
            print("App is Inactive")
            #endif
        }
        get {
            return appInactiveStatus
        }
    }
    
    public var isAppInBackground: Bool {
        set {
            appInBackgroundStatus = newValue
            self.appInBackground.send(self)
            #if DEBUG
            print("App is In Background")
            #endif
        }
        get {
            return appInBackgroundStatus
        }
    }
    
    // For displaying more info per device on the device list
    @Configuration(key: "showInfoOnList", defaultValue: true)
    var showInfoOnList: Bool
    
    // Array of device objects
    @Configuration(key: "Devices", defaultValue: [DeviceModel]())
    var deviceList: [DeviceModel]
    
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
