//
//  InfoView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 14.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var options: OptionsStore
    var deviceMAC: String
    var more: Bool
    var color: Color? = Color.gray
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Divider()
            Text("MAC: " + deviceMAC)
                .font(.footnote)
                .foregroundColor(self.color)
            Text("Firmware: " + FWVersion(fwv: options.doorOptions.fwv ))
                .font(.footnote)
                .foregroundColor(self.color)
            Text("WLAN: " + options.doorOptions.ssid)
                .font(.footnote)
                .foregroundColor(self.color)
            Text("Gateway: " + options.doorOptions.gwip)
                .font(.footnote)
                .foregroundColor(self.color)
            if self.more {
                Text("Subnet: " + options.doorOptions.subn)
                    .font(.footnote)
                    .foregroundColor(self.color)
                Text("DNS1: " + options.doorOptions.dns1)
                    .font(.footnote)
                    .foregroundColor(self.color)
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

func FWVersion(fwv: Int) -> String {
    
    if (fwv == 0) {
        return "000"
    }
    let str: String = String(fwv)
    let chr1: String = String(str.character(at: 0) ?? "0")
    let chr2: String = String(str.character(at: 1) ?? "0")
    let chr3: String = String(str.character(at: 2) ?? "0")
    
    return chr1 + "." + chr2 + "." + chr3
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(options: OptionsStore(),
                 deviceMAC: "2b:cd:4e:57:77:90", more: true)
    }
}

