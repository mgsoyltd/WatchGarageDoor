//
//  DeviceView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 2.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI
import Combine

struct DeviceView: View {
    
    @EnvironmentObject var config: Config
    
    @State private var index: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            SwiperView(index: self.$index, deviceList: self.$deviceList)
            //            HStack(spacing: 8) {
            //                ForEach(0..<self.deviceList.getDeviceCount()) { index in
            //                    CircleButton(isSelected: Binding<Bool>(get: { self.index == index }, set: { _ in })) {
            //                        withAnimation {
            //                            self.index = index
            //                        }
            //                    }
            //                }
            //            }
            //            .padding(.bottom, 12)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView()
    }
}

struct CircleButton: View {
    
    @Binding var isSelected: Bool
    
    let action: () -> Void
    
    var body: some View {
        Circle()
            .frame(width: 8, height: 8)
            .foregroundColor(self.isSelected ? Color.white : Color.white.opacity(0.5))
        
        //        Button(action: {
        //            self.action()
        //        }) { Circle()
        //            .frame(width: 8, height: 8)
        //            .foregroundColor(self.isSelected ? Color.white : Color.white.opacity(0.5))
        //        }
        //        .fixedSize()
        //        .frame(height: 50)
    }
}

struct AddButton: View {
    
    let action: () -> Void
    
    var body: some View {
        
        VStack {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 50, height: 50)
            //                .aspectRatio(contentMode: .fit)
            
            Button (action: {
                self.action()
            }, label: {
                Text("New Device")
            })
        }
    }
}

struct SwiperView: View {
    @Binding var index: Int
    @Binding var deviceList: Config
    
    @State private var offset: CGFloat = 0
    @State private var isUserSwiping: Bool = false
    @State private var optionsVC = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(0..<self.deviceList.getDeviceCount()) { index in
//                        StatusView(index: self.$index, deviceList: self.$deviceList)
                        Text("TEST")
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                    }
                        //                    // Button to add a new device
                        //                    AddButton(action: {
                        //                        self.optionsVC.toggle()
                        //                        if (self.optionsVC) {
                        //                            _ = self.deviceList.newDevice(device: DeviceModel())
                        //                            self.index = self.deviceList.getDeviceCount()
                        //                        }
                        //                    })
//                        .sheet(isPresented: self.$optionsVC) {
//                            OptionsView(index: self.$index, deviceList: self.$deviceList)
//                    }
                }
            }
            .content
            .offset(x: self.isUserSwiping ? self.offset : CGFloat(self.index) * -geometry.size.height)
            .frame(width: geometry.size.height, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.isUserSwiping = true
                        self.offset = value.translation.width + -geometry.size.width * CGFloat(self.index)
                    })
                    .onEnded({ value in
                        if value.predictedEndTranslation.width < geometry.size.width / 2, self.index < self.deviceList.getDeviceCount() - 1 {
                            self.index += 1
                            _ = self.deviceList.getDevice(index: self.index)
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                            self.index -= 1
                            _ = self.deviceList.getDevice(index: self.index)
                        }
                        withAnimation {
                            self.isUserSwiping = false
                        }
                    })
            )
        } // GeometryReader
    }
}
