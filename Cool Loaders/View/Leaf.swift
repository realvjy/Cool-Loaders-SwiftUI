//
//  Leaf.swift
//  Cool Loaders
//
//  Created by vijay verma on 24/12/23.
// TODO logic

import SwiftUI

struct CircleLeaf: View {
    let scaleW: CGFloat
    let scaleH: CGFloat
    let color: Color
    var body: some View {
        GeometryReader { geometry in
            Ellipse()
                .fill(color)
                .frame(width: 40 * scaleW, height: 40)
        }
    }
}


struct Leaf: View {
    var body: some View {
            VStack {
                CircleAnimationView()
                    .padding()
                    .frame(width: 200, height: 200) // Adjust size as needed
            }
        }
}

struct CircleAnimationView: View {
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { index in
                Circle()
                    .frame(width: index == 0 ? 50 : 40, height: index == 0 ? 50 : 40)
                    .foregroundColor(.blue)
                    .opacity(index == 0 ? 1.0 : 0.6) // First circle fully visible, others slightly transparent
                    .offset(x: self.offsetX + CGFloat(index - 1) * 60)
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                self.offsetX = -180 // Adjust the total movement distance
            }
        }
    }
}

#Preview {
    Leaf()
}
