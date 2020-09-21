//
//  DoorView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 17.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct DoorView: View {
    var index: Int
    var status: GarageDoorStatus
    @Binding var commandVC: Bool
    
    @EnvironmentObject var config: Config
    
    @ObservedObject var controlModel = Controller()
    
    @State private var timeLeft: CGFloat = 0
    @State private var fadeOut     = true
    @State private var showAlert   = true
    @State private var img         = String()
    @State private var imageStep   = 0
    @State private var imageIndex  = 0
    @State private var imagePrefix = "GarageDoorIcon_"
    @State private var cmdError    = false
    @State private var titleBar    = ""
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let imageCount = 6
    
    var body: some View {
        Group {
            VStack {
                ZStack {
                    if self.imageIndex > 0 && !self.cmdError {
                        Image(img)
                            .resizable()
                            .frame(width: 200.0, height: 180.0)
                            .clipped(antialiased: true)
                            .cornerRadius(10.0)
                            .opacity(fadeOut ? 0 : 1)
                            .animation(.easeInOut(duration: 5.0))
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                            .onReceive(timer) { _ in
                                if (!config.isAppActive) {
                                    #if DEBUG
                                    print("App in the background - stop animation")
                                    #endif
                                    self.timeLeft = 0
                                    self.fadeOut = true
                                    self.commandVC = false      // Dismiss this view
                                }
                                if self.timeLeft > 0 {
                                    self.timeLeft -= 1
                                    if self.isEven(Int(self.timeLeft)) {
                                        self.imageIndex += self.imageStep
                                        if self.imageIndex > 0 && self.imageIndex <= self.imageCount {
                                            self.img = "\(self.imagePrefix)\(String(self.imageIndex))"
                                            print(self.img)
                                        }
                                    }
                                }
                                if self.timeLeft == 0 {
                                    self.fadeOut = true
                                    self.commandVC = false      // Dismiss this view
                                }
                            }
                    }
                } // ZStack
            } // VStack
            .navigationBarTitle(titleBar)
            
            if self.cmdError {
                // Controller error
                Text(self.controlModel.changeStatus.alert)
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .onReceive(self.controlModel.didChange) { value in
            self.cmdError = self.controlModel.changeStatus.error
            if self.cmdError {
                self.titleBar = "Close"
            }
            else {
                // Activate door open/close animation
                self.fadeOut = false
                if self.status.cmdText == "Open" {
                    self.imageStep = 1
                    self.imageIndex = 1
                    self.img = "\(self.imagePrefix)\(String(self.imageIndex))"
                }
                else {  // Close
                    self.imageStep = -1
                    self.imageIndex = 6
                    self.img = "\(self.imagePrefix)\(String(self.imageIndex))"
                }
                self.timeLeft = 12.0     // Start animation
            }
        }
        
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("\(self.status.cmdText) \(self.status.name)"),
                  message: Text("Are you sure?"),
                  primaryButton: .destructive(Text(self.status.cmdText)) {
                    self.doCommand()
                  }, secondaryButton: .cancel {
                    self.commandVC = false      // Dismiss this view
                  }
            )
        }
        
    }
    
    private func doCommand() {
        // Send device open or close command depending on the door state
        let args = "?dkey=\(self.config.deviceList[self.index].Key)&\(self.status.cmdText.lowercased())=1"
        self.controlModel.send(url: self.config.deviceList[self.index].getURL(), args: args)
    }
    
    private func isEven(_ value: Int) -> Bool {
        return (value % 2 == 0)
    }
    
}

struct DoorView_Previews: PreviewProvider {
    
    static var previews: some View {
        DoorView(index: 0, status: GarageDoorStatus(), commandVC: .constant(true))
    }
}


