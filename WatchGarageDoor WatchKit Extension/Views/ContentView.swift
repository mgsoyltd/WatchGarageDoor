//
//  ContentView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 25.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var index: Int
    
    @EnvironmentObject var config: Config
    
    @ObservedObject var statusModel  = StatusStore()
    @ObservedObject var optionsModel = OptionsStore()
    @ObservedObject var logModel     = LogStore()
    
    @State var currentIndex        = 0.0
    @State private var optionsVC   = false
    @State private var infoVC      = false
    @State private var validDevice = false
    @State var commandVC           = false
    
    var doorLog: [GarageDoorLog] = []
    
    var body: some View {
        ZStack {
            Section {
                List(logModel.doorLog) { log in
                    HStack {
                        Image(log.imageName)
                            .resizable()
                            .frame(width: 50, height: 40, alignment: .leading)
                        Text(log.timeStamp)
                    }
                }
                .onAppear(perform: {
                    // Request the status log data from the device
                    self.fetchLog(index: self.index)
                })
  
                .onReceive(self.statusModel.didChange) { value in
                    self.validDevice = ( self.statusModel.doorStatus.mac != "" )
                 }
            }
            // Possible error messages
            Text(self.logModel.changeStatus.alert)
                .foregroundColor(.red)
                .font(.footnote)
                .padding(.bottom, 10)
        }
        .navigationBarTitle("Status Log")
        .digitalCrownRotation(
            $currentIndex.animation(),
            from: 0.0,
            through: Double(logModel.doorLog.count - 1),
            by: 1.0,
            sensitivity: .low
        )
            .contextMenu {
    
                // Open/Close command
                if self.validDevice {
                    Button (action: {
                        self.commandVC.toggle()
                    }, label: {
                        VStack {
                            Image(systemName: self.statusModel.doorStatus.cmdButton)
                            Text(self.statusModel.doorStatus.cmdText)
                        }
                    })
                        .sheet(isPresented: self.$commandVC) {
                            DoorView(index: self.index, status: self.statusModel.doorStatus, commandVC: self.$commandVC)
                                .environmentObject(self.config)
                    }
                    
                    // Info
                    Button(action: {
                        self.infoVC.toggle()
                    }, label: {
                        VStack{
                            Image(systemName: "info")
                                .font(.title)
                            Text("Info")
                        }
                    })
                    .sheet(isPresented: self.$infoVC) {
                        Text(self.statusModel.doorStatus.name)
                            .font(.headline)
                            .foregroundColor(Color.blue)
                        InfoView(options: self.optionsModel,
                                 deviceMAC: self.$statusModel.doorStatus.mac, more: true)
                        .navigationBarTitle("Close")
                    }
                }

                // Maintain settings
                Button(action: {
                    self.optionsVC.toggle()
                }, label: {
                    VStack{
                        Image(systemName: "gear")
                            .font(.title)
                        Text("Settings")
                    }
                })
                .sheet(isPresented: self.$optionsVC) {
                    OptionsView(index: self.index, device: self.config.deviceList[self.index])
                        .environmentObject(self.config)
                }
        }
            .edgesIgnoringSafeArea(.bottom)
    }
    
    private func fetchLog(index: Int) {
        // Request device status data from the device
        self.statusModel.fetch(url: self.config.deviceList[self.index].getURL())
        // Request door status log from the device
        self.logModel.fetch(url: self.config.deviceList[self.index].getURL(),
                            logRows: self.config.deviceList[self.index].getLogRows())
        // Request controller options from the device
        self.optionsModel.fetch(url: self.config.deviceList[self.index].getURL())
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(index: 0, statusModel: StatusStore())
    }
}
#endif



