//
//  ListMenuView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 17.9.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct ListMenuView: View {
    
    @EnvironmentObject var config: Config
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newVC = false
    @State private var optionsVC = false
    @State private var infoVC = false
    @State private var aboutVC = false
    @State private var editVC = false
    
    @State private var newIndex: Int = -1
    
    var body: some View {
        
        VStack {
            
            // Add device
            Button(action: {
                self.newVC.toggle()
                if (self.newVC) {
                    self.newIndex = -1
                }
            }) {
                Label("New device", systemImage: "plus")
            }
            .sheet(isPresented: $newVC) {
                OptionsView(index: self.newIndex, device: DeviceModel())
                    .environmentObject(config)
            }
            
            // Edit view
            Button(action: {
                self.editVC.toggle()
            }) {
                Label("Edit", systemImage: "list.dash")
            }
            .sheet(isPresented: $editVC) {
                EditView().environmentObject(config)
            }
            
            // About view
            Button(action: {
                self.aboutVC.toggle()
            }) {
                Label("About", systemImage: "c.circle")
            }
            .sheet(isPresented: $aboutVC) {
                AboutView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction ) {
                Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
    }
}

struct ListMenuView_Previews: PreviewProvider {
    static let config = Config()
    
    static var previews: some View {
        ListMenuView()
    }
}
