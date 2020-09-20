//
//  EditView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 17.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var config: Config
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showConfirm = false
    @State private var idxSet = IndexSet()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.config.deviceList, id:\.id) { item in
                    VStack {
                        Text(item.name)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    }
                }
                .onMove(perform: onMove)
                .onDelete(perform: onDelete)
                .animation(.easeOut)
            }
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction ) {
                    Button("Done") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            .alert(isPresented: self.$showConfirm) {
                Alert(title: Text("Delete device"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteItem()
                }, secondaryButton: .cancel()
                )
            }
        }
    }
    
    
    private func onMove(from source: IndexSet, to destination: Int) {
        self.config.moveDevice(from: source, to: destination)
    }
    
    private func onDelete(at idxs: IndexSet) {
        self.showConfirm = true
        self.idxSet = idxs
    }
    
    private func deleteItem() {
        self.showConfirm = false
        self.config.deleteDevices(self.idxSet)
    }
    
}

struct EditView_Previews: PreviewProvider {
    static let config = Config()
    
    static var previews: some View {
        EditView()
    }
}

