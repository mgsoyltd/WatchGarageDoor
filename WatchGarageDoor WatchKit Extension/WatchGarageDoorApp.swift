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
        
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DeviceListView().environmentObject(Config())
            }
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
