//
//  WatchGarageDoorApp.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 19.9.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

@main
struct WatchGarageDoorApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @StateObject var config = Config()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DeviceListView().environmentObject(config)
            }
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            config.isAppActive       = (newValue == .active)
            config.isAppInactive     = (newValue == .inactive)
            config.isAppInBackground = (newValue == .background)
        }
        
    }
    
}
