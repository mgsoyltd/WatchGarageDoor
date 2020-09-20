//
//  DeviceListView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 4.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct DeviceListView: View {
    
    @EnvironmentObject var config: Config
    
    @State private var settingsVC = false
    
    private var isActive = NotificationCenter.default.publisher(for: .applicationIsActive)
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.config.deviceList.indices, id: \.self) { index in
                    NavigationLink(destination: ContentView(index: index)) {
                        StatusView(index: index)
                    }
                }
            } // List
            .listStyle(CarouselListStyle())
            
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                    Button("Setup ") {
                        self.settingsVC.toggle()
                    }
                }
            }
            .sheet(isPresented: $settingsVC) {
                ListMenuView()
            }
            
            if self.config.deviceList.count == 0 {
                Text("Please, add a device")
                    .font(.headline)
                    .foregroundColor(.yellow)
            }
            
        } // ZStack

        .edgesIgnoringSafeArea(.bottom)

    }
    
}



struct DeviceListView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            
            DeviceListView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm"))
                .previewDisplayName("Series 5 - 44mm")
            
//            DeviceListView()
//                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
//                .previewDisplayName("Series 4 - 44mm")
//
//            DeviceListView()
//                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 40mm"))
//                .previewDisplayName("Series 5 - 40mm")
//
//            DeviceListView()
//                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 42mm"))
//                .previewDisplayName("Series 3 - 42mm")
        }
    }
}

