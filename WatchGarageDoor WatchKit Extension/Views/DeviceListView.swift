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
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var statusModel  = StatusStore()
    @ObservedObject var optionsModel = OptionsStore()
    @ObservedObject var controlModel = Controller()
    
    @State private var newVC = false
    @State private var optionsVC = false
    @State private var infoVC = false
    @State private var aboutVC = false
    @State private var editVC = false
    @State private var doorStatus = 0
    
    @State var currentIndex = 0.0
    
    @State private var newIndex: Int = 0
    @State private var dispHello = false
    @State private var idxSet = IndexSet()
    
    private var isActive = NotificationCenter.default.publisher(for: .applicationIsActive)
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.config.deviceList.indices, id: \.self) { index in
                    NavigationLink(destination: ContentView(index: index)
                        .environmentObject(self.config)) {
                            StatusView(index: index)
                                .environmentObject(self.config)
                    }
                }
            } // LIst
            
            if self.config.deviceList.count == 0 {
                Text("Please, add a device")
                    .font(.headline)
                    .foregroundColor(.yellow)
            }
        }
            
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("Devices")
            
//            // First lauch screen
//            .onAppear(perform: showFirstLauch)
//            .sheet(isPresented: $dispHello) {
//                HomeView()
//        }
            
        .onReceive(isActive) {_ in
            self.reload()
        }
            
            
            // Context menu items
            .contextMenu {
                
                // Add device
                Button(action: {
                    self.newVC.toggle()
                    if (self.newVC) {
                        self.newIndex = self.config.newDevice()
                    }
                }, label: {
                    VStack{
                        Image(systemName: "plus")
                            .font(.title)
                        Text("New device")
                    }
                })
                    .sheet(isPresented: $newVC) {
                        OptionsView(index: self.newIndex, device: self.config.deviceList[self.newIndex])
                            .environmentObject(self.config)
                }
                
                // Edit view
                Button(action: {
                    self.editVC.toggle()
                }, label: {
                    VStack{
                        Image(systemName: "list.dash")
                            .font(.title)
                        Text("Edit")
                    }
                }).sheet(isPresented: $editVC) {
                    EditView().environmentObject(self.config)
                }
                
                
                // About view
                Button(action: {
                    self.aboutVC.toggle()
                }, label: {
                    VStack{
                        Image(systemName: "c.circle")
                            .font(.title)
                        Text("About")
                    }
                }).sheet(isPresented: $aboutVC) {
                    AboutView()
                }
        }   // contextMenu
        
    }
    
    private func reload() {
        let devs = self.config.deviceList.map( { $0.name })
        #if DEBUG
        print(devs)
        #endif
    }
    
//    private func showFirstLauch() {
//        // Display welcome screen once a day or when version has changed
//        #if DEBUG
//        print("firstLauch: \(justDate(config.firstLaunch)) vs Date(): \(justDate(Date()))")
//        #endif
//        if justDate(config.firstLaunch) < justDate(Date()) ||
//            config.lastVersion != getAppVersion() {
//            dispHello = true
//            config.firstLaunch = Date()
//            config.lastVersion = getAppVersion()
//        }
//    }
//
//    func justDate(_ originalDate: Date) -> Date {
//        let components = Calendar.current.dateComponents([.year, .month, .day], from: originalDate)
//        let date = Calendar.current.date(from: components)
//        return date!
//    }
    
}

struct DeviceListView_Previews: PreviewProvider {
    
    static let config = Config()
    
    static var previews: some View {
        DeviceListView()
            .environmentObject(config)
    }
}

