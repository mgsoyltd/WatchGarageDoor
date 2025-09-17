//
//  SignalStrengthView.swift
//  WatchGarageDoor WatchKit Extension
//
//  Created by mgs on 21.5.2020.
//  Copyright © 2020 Morning Glow Solutions Oy Ltd. All rights reserved.
//

import SwiftUI

struct SignalStrengthView: View {
    var bars: Int
    var totalBars: Int = 3
    var text: String = ""
    
    var body: some View {
        HStack {
            Text("NNNNN").hidden().overlay(SignalStrengthIndicator(bars: bars, totalBars: totalBars))
                .font(.footnote)
            if text != "" {
                Text(text).font(.footnote)
            }
        }
    }
}

struct SignalStrengthView_Previews: PreviewProvider {
    static var previews: some View {
        SignalStrengthView(bars: 3, text: "-75 dBm")
    }
}

struct Divided<S: Shape>: Shape {
    var amount: CGFloat // Should be in range 0...1
    var shape: S
    func path(in rect: CGRect) -> Path {
        shape.path(in: rect.divided(atDistance: amount * rect.height, from: .maxYEdge).slice)
    }
}

extension Shape {
    func divided(amount: CGFloat) -> Divided<Self> {
        return Divided(amount: amount, shape: self)
    }
}

struct SignalStrengthIndicator: View {
    var bars: Int = 5
    var totalBars: Int = 5
    
    var body: some View {
        HStack {
            ForEach(Array(0..<totalBars), id: \.self) { bar in
                RoundedRectangle(cornerRadius: 3)
                    .divided(amount: (CGFloat(bar) + 1) / CGFloat(self.totalBars))
                    .fill(Color.primary.opacity(bar < self.bars ? 1 : 0.3))
                    .frame(width: 6)
            }
        }
    }
}


