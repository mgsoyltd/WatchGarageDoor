//
//  OptionsView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 9.11.2019.
//  Copyright © 2019 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

public struct OptionsView: View {
    var index: Int
    var device: DeviceModel
    
    @EnvironmentObject var config: Config
    @Environment(\.presentationMode) var presentationMode
    
    @State private var validIP   = FieldChecker()
    @State private var validPort = FieldChecker()
    @State private var validKey  = FieldChecker()
    
    @State private var name      = String()
    @State private var IP        = String()
    @State private var Port      = String()
    @State private var Key       = String()
    @State private var LogRowIdx = 0
    @State private var showInfo  = true
    
    init(index: Int, device: DeviceModel) {
        self.index      = index
        self.device     = device
        self._name      = State(initialValue: device.name)
        self._IP        = State(initialValue: device.IP)
        self._Port      = State(initialValue: device.Port)
        self._Key       = State(initialValue: device.Key)
        self._LogRowIdx = State(initialValue: device.LogRowIdx)
    }
    
    @State private var showingDeleteAlert = false
    
    public var body: some View {
        
        Form {
            Section {
                
                Name()
                IpAddress()
                PortNumber()
                DeviceKey()
                LogEntries()
                ShowInfo()
                
            } // end of section
            Section {
                // Save action
                Button(action: {
                    // Save changes
                    self.config.deviceList[self.index].name      = self.name
                    self.config.deviceList[self.index].IP        = self.IP
                    self.config.deviceList[self.index].Port      = self.Port
                    self.config.deviceList[self.index].Key       = self.Key
                    self.config.deviceList[self.index].LogRowIdx = self.LogRowIdx
                    self.config.showInfoOnList                   = self.showInfo
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
                .padding([.leading, .trailing])
                .foregroundColor(.blue)
                .accentColor(.blue)
                    // enable button only if user inputs are valid
                    .disabled( !(validIP.valid && validPort.valid && validKey.valid) )
                
            } // end of section
        } // end of form
        
        .onAppear() {
            // Default value for Show More Info boolean from User Defaults
            self.showInfo = self.config.showInfoOnList
        }
    }
    
    func Name() -> some View {
        VStack {
            TextField("Text", text: self.$name)
                .frame(height: 40)
                .padding([.leading, .trailing])
                .font(.body)
                .border( validIP.valid ? Color.clear : Color.red )
        }
    }
    
    func IpAddress() -> some View {
        VStack {
            TextFieldWithValidator( title: "IP Address",
                                    value: self.$IP, checker: $validIP ) { v in
                                        // validation closure where ‘v’ is the current value
                                        if( !v.isValidIP() ) {
                                            return "Invalid IP address"
                                        }
                                        return nil
            }
            .frame(height: 40)
            .padding([.leading, .trailing])
            .font(.body)
            .border( validIP.valid ? Color.clear : Color.red )
            if( !validIP.valid ) {
                Text( validIP.errorMessage ?? "" )
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(Color.red)
            }
        }
    }
    
    func PortNumber() -> some View {
        VStack {
            TextFieldWithValidator( title: "Port Number",
                                    value: self.$Port, checker: $validPort ) { v in
                                        // validation closure where ‘v’ is the current value
                                        if( v.isEmpty || v < "80" ) {
                                            return "Invalid Port"
                                        }
                                        return nil
            }
            .frame(height: 40)
            .padding([.leading, .trailing])
            .font(.body)
            .border( validPort.valid ? Color.clear : Color.red )
            if( !validPort.valid  ) {
                Text( validPort.errorMessage ?? "" )
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(Color.red)
            }
        }
    }
    
    func DeviceKey() -> some View {
        VStack {
            SecureFieldWithValidator( title: "Device Key",
                                      value: self.$Key, checker: $validKey ) { v in
                                        // validation closure where ‘v’ is the current value
                                        if( v.isEmpty ) {
                                            return "Key cannot be empty"
                                        }
                                        return nil
            }
            .frame(height: 40)
            .padding([.leading, .trailing])
            .font(.body)
            .border( validKey.valid ? Color.clear : Color.red )
            if( !validKey.valid  ) {
                Text( validKey.errorMessage ?? "" )
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(Color.red)
            }
        }
    }
    
    func LogEntries() -> some View {
        VStack {
            Picker(selection: self.$LogRowIdx, label: Text("Log Entries")) {
                ForEach(0 ..< self.config.deviceList[index].LogRowsPickList.count) {
                    Text(self.config.deviceList[self.index].LogRowsPickList[$0])
                }
            }
            .frame(height: 40)
            .padding([.leading, .trailing])
            .font(.body)
            .border( Color.clear )
        }
    }
    
    func ShowInfo() -> some View {
        VStack {
            Toggle(isOn: $showInfo) {
                Text("Show more info")
            }
        }
    }
}

#if DEBUG
struct OptionsView_Previews: PreviewProvider {
    static var device = DeviceModel()
    
    static var previews: some View {
        OptionsView(index: 0, device: device)
    }
}
#endif
