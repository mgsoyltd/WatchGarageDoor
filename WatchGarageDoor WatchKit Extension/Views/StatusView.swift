//
//  StatusView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 26.8.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI
import Combine

struct StatusView: View {
    var index: Int
    
    @EnvironmentObject var config: Config
    
    @ObservedObject var statusModel  = StatusStore()
    @ObservedObject var optionsModel = OptionsStore()
    
    @State private var optionsVC = false
    @State private var infoVC    = false
    @State private var aboutVC   = false
    
    public var body: some View {
        
        ZStack {
            
            VStack {
                
                Section(header: Text(self.index < config.deviceList.count ?
                    config.deviceList[index].name : statusModel.doorStatus.name)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                ) {
                    HStack {
                        Image(statusModel.doorStatus.statusImage)
                            .resizable()
                            .frame(width: 80.0, height: 60.0)
                            .clipped(antialiased: true)
                            .cornerRadius(10.0)
                        //  .rotation3DEffect(.degrees(25), axis: (x: 0, y: 2, z: 0))
                        
                        VStack {
                            Text("Vehicle:")
                                .font(.footnote).foregroundColor(.gray)
                            Text(statusModel.doorStatus.vehicleStatus)
                                .font(.footnote)
                                .foregroundColor(statusModel.doorStatus.vehicle == 0 ? .red : .green)
                        } // Vstack
                        
                    } // HStack
                }
                if self.config.showInfoOnList {
                    InfoView(options: optionsModel,
                             deviceMAC : self.$statusModel.doorStatus.mac, more: false)
                    SignalStrength()
                }
                
                // Possible error message
                Spacer()
                Text(statusModel.changeStatus.alert)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.bottom, 10)
                
            } // Vstack
            
        } // ZStack
            
            .onAppear {
                if (self.index < self.config.deviceList.count) {
                    self.statusModel.fetch(url: self.config.deviceList[self.index].getURL())
                    self.optionsModel.fetch(url: self.config.deviceList[self.index].getURL())
                }
        }
        .onReceive(self.statusModel.didChange) { _ in
            // Primarily use the name from the device 
            if self.index < self.config.deviceList.count &&
                self.statusModel.doorStatus.name != "" && self.statusModel.doorStatus.name != self.config.deviceList[self.index].name {
                self.config.deviceList[self.index].name = self.statusModel.doorStatus.name
            }
        }
        
    }
    
    private func SignalStrength() -> some View {
        
        enum Strength: Int {
            case nocon
            case poor
            case weak
            case good
        }
        
        // var signalstrength= jd.rssis[i]>-71?'Ok':(jd.rssis[i]>-81?'Weak':'Poor');
        let signal = self.statusModel.doorStatus.rssi
        
        return
            HStack {
                Text("Signal:")
                    .font(.footnote)
                    .foregroundColor(.gray)
                SignalStrengthView(bars:
                    signal == 0  ? Strength.nocon.rawValue :
                    signal > -71 ? Strength.good.rawValue :
                    signal > -81 ? Strength.weak.rawValue : Strength.poor.rawValue)
                //            text: "\(signal) dB")
        }
    }
}

#if DEBUG
struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        //        StatusView(index: 0).environmentObject(Config())
        
        Group {
            StatusView(index: 0).environmentObject(Config())
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
                .previewDisplayName("Series 4 - 44mm")
            
            StatusView(index: 0).environmentObject(Config())
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm"))
                .previewDisplayName("Series 5 - 44mm")
            
            StatusView(index: 0).environmentObject(Config())
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 40mm"))
                .previewDisplayName("Series 5 - 40mm")
            
            StatusView(index: 0).environmentObject(Config())
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 42mm"))
                .previewDisplayName("Series 3 - 42mm")
        }
    }
}
#endif



