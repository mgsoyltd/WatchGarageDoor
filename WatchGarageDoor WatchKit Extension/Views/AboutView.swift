//
//  AboutView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 28.4.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text(getProduct())
                .foregroundColor(.yellow)
            Text("v\(getAppVersion()) (\(getBuildVersion()))")
                .font(.footnote)
                .foregroundColor(.accentColor)
            Divider()
            Text("Copyright © 2020")
                .font(.footnote)
                .foregroundColor(.gray)
            Text("All rights reserved.")
                .font(.footnote)
                .foregroundColor(.gray)
            Text("Morning Glow")
                .font(.footnote)
                .foregroundColor(.orange)
            Text("Solutions Oy Ltd")
                .font(.footnote)
                .foregroundColor(.orange)
            Text("www.mgsoy.com")
                .font(.footnote)
                .foregroundColor(.blue)
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
                .previewDisplayName("Series 4 - 44mm")

            AboutView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm"))
                .previewDisplayName("Series 5 - 44mm")
            
            AboutView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 5 - 40mm"))
                .previewDisplayName("Series 5 - 40mm")
            
            AboutView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 42mm"))
                .previewDisplayName("Series 3 - 42mm")
        }
    }
}

func getProduct() -> String {
    
    return Bundle.main.productName!
}

func getAppVersion() -> String {
    
    return Bundle.main.versionNumber!
}

func getBuildVersion() -> String {
    
    return Bundle.main.buildNumber!
}

extension Bundle {
    
    // Product name
    var productName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    // Version number
    var versionNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    // Build Number
    var buildNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
}
