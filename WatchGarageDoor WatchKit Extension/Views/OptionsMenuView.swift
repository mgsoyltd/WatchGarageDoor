//
//  OptionsMenuView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 20.9.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct OptionsMenuView: View {
    var index: Int
    var validDevice: Bool
    var doorStatus: GarageDoorStatus
    var optionsModel: OptionsStore
    
    @EnvironmentObject var config: Config
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var optionsVC = false
    @State private var infoVC    = false
    @State var commandVC         = false
    
    var body: some View {
        
        VStack {
            // Open/Close command
            if self.validDevice {
                Button(action: {
                    self.commandVC.toggle()
                }) {
                    Label(self.doorStatus.cmdText,
                          systemImage: self.doorStatus.cmdButton)
                }
                .sheet(isPresented: self.$commandVC) {
                    DoorView(index: self.index, status: self.doorStatus, commandVC: self.$commandVC)
                        .environmentObject(config)
                }
                
                // Info
                Button(action: {
                    self.infoVC.toggle()
                }) {
                    Label("Info", systemImage: "info")
                }
                .sheet(isPresented: self.$infoVC) {
                    InfoView(options: self.optionsModel,
                             deviceMAC: self.doorStatus.mac,
                             more: true,
                             color: .green,
                             name: self.doorStatus.name)
                }
            }
            
            // Maintain settings
            Button(action: {
                self.optionsVC.toggle()
            }) {
                Label("Settings", systemImage: "gear")
            }
            .sheet(isPresented: self.$optionsVC) {
                OptionsView(index: self.index,
                            device: self.config.deviceList[self.index])
                    .environmentObject(config)
            }
        } // VStack
        
        .toolbar {
            ToolbarItem(placement: .cancellationAction ) {
                Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
    }
}

struct OptionsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsMenuView(index: 0,
                        validDevice: true,
                        doorStatus: GarageDoorStatus(),
                        optionsModel: OptionsStore())
    }
}
