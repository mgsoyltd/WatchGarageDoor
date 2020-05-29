//
//  HomeView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 5.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
//    private enum ImageEnum: String {
//        case shut = "GarageDoorShut"
//        case open = "GarageDoorOpen"
//        case none = ""
//
//        func next() -> ImageEnum {
//            switch self {
//            case .shut: return .open
//            case .open: return .shut
//            case .none: return .none
//            }
//        }
//
//        func first() -> ImageEnum {
//            return .shut
//        }
//    }
    
    @State private var showAbout = true
//    @State private var startApp = false
//    @State private var fadeOut = false
//    @State private var timeLeft:CGFloat = 12.0
//    @State private var img = ImageEnum.shut
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
//            Image(img.rawValue)
//                .resizable()
//                .frame(width: 200.0, height: 180.0)
//                .clipped(antialiased: true)
//                .cornerRadius(10.0)
//                .opacity(fadeOut ? 0 : 1)
//                //                .rotation3DEffect(.degrees(25), axis: (x:self.timeLeft * 100.0, y: self.timeLeft * -100.0, z: self.timeLeft * 100.0))
//                .animation(.easeInOut(duration: 1.0))
//                .onReceive(timer) { _ in
//                    if self.timeLeft > 0 {
//                        self.timeLeft -= 1
//                    }
//                    if self.timeLeft > 6 {
//                        self.img = self.img.next()
//                    }
//                    else {
//                        self.img = self.img.first()
//                        self.fadeOut = true
//                        self.showAbout = true
//                    }
//                    if self.timeLeft == 0 {
//                        self.startApp = true
//                    }
//            }
//            .onTapGesture {
//                self.timeLeft = 2
//            }
            
            if self.showAbout {
                Form {
                    AboutView()
                        .background(Color(.black))
                }
            }
        }
        .navigationBarTitle("")
        .padding(.top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            HomeView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
                .previewDisplayName("Series 4 - 44mm")
            
            HomeView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm"))
                .previewDisplayName("Series 5 - 44mm")
            
            HomeView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 40mm"))
                .previewDisplayName("Series 5 - 40mm")
            
            HomeView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 42mm"))
                .previewDisplayName("Series 3 - 42mm")
        }
    }
}

