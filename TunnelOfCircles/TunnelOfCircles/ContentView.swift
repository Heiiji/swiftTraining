//
//  ContentView.swift
//  TunnelOfCircles
//
//  Created by Julien Juret on 21/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var colors: [Color] = [.cyan, .blue]
    @State private var depth = 0.0
    
    let minDiameter = 50.0
    let diameterChange = 70.0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Tunnel of circles")
                .font(.largeTitle)
                .padding()
            ZStack {
                ForEach(0..<4) { index in
                    Circle()
                        .stroke(lineWidth: 30)
                        .foregroundStyle(colors[index % 2])
                        .frame(height: minDiameter + diameterChange * Double(index))
                        .padding3D(.back, depth)
                }
            }
            .padding(.bottom, 30)
            Grid {
                GridRow {
                    Text("Depth")
                    Slider(value: $depth, in: 0...50){
                        Text("Depth")
                    }
                }
                GridRow {
                    Text("Colors")
                    HStack {
                        ColorPicker("Color", selection: $colors[0])
                        ColorPicker("Color", selection: $colors[1])
                        Spacer()
                    }
                    .labelsHidden()
                }
            }
            .padding(30)
            .background(.thickMaterial)
            .frame(maxWidth: 350)
        }
        .frame(minHeight: 570)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}