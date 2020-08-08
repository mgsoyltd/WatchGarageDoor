//
//  HostingController.swift
//  WatchGarageDoor WatchKit Extension
//
//  The initial interface controller
//
//  Created by mgs on 25.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<AnyView> {
    
    override var body: AnyView {
        AnyView(DeviceListView().environmentObject(Config()))
    }
    
}
