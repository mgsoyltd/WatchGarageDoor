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
    
    @StateObject var statusModel  = StatusStore()
    @StateObject var optionsModel = OptionsStore()
    @StateObject var logModel     = LogStore()
    
    @State var currentIndex        = 0.0
    @State private var validDevice = false
    
    @State private var moreVC = false
    
    var body: some View {
        VStack {
            Section {
                List(logModel.doorLog) { log in
                    HStack {
                        Image(log.imageName)
                            .resizable()
                            .frame(width: 50, height: 40, alignment: .leading)
                        Text(log.timeStamp)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Options") {
                        self.moreVC.toggle()
                    }
                }
            }
            .sheet(isPresented: $moreVC) {                
                OptionsMenuView(index: self.index,
                                validDevice: self.validDevice,
                                doorStatus: self.statusModel.doorStatus,
                                optionsModel: self.optionsModel)
                    .environmentObject(config)
            }
            
            // Possible error messages
            Text(self.logModel.changeStatus.alert)
                .foregroundColor(.red)
                .font(.footnote)
                .padding(.bottom, 10)
        }
        .navigationBarTitle("Status Log")
        .modifier(
            ConditionalDigitalCrownModifier(
                isEnabled: logModel.doorLog.count > 1,
                binding: $currentIndex,
                maxValue: Double(logModel.doorLog.count - 1)
            )
        )
        .edgesIgnoringSafeArea(.bottom)
        
        .onAppear(perform: {
            // Request the status log data from the device
            self.fetchLog(index: self.index)
        })
        
        .onReceive(self.statusModel.$doorStatus) { doorStatus in
            self.validDevice = ( doorStatus.mac != "" )
        }
        
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

struct ConditionalDigitalCrownModifier: ViewModifier {
    let isEnabled: Bool
    let binding: Binding<Double>
    let maxValue: Double

    func body(content: Content) -> some View {
        if isEnabled && maxValue > 0 {
            content
                .digitalCrownRotation(
                    binding.animation(),
                    from: 0.0,
                    through: maxValue,
                    by: 1.0,
                    sensitivity: .low
                )
        } else {
            content
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(index: 0, statusModel: StatusStore())
    }
}
#endif



