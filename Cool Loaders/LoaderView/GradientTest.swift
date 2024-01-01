//
//  GradientTest.swift
//  Cool Loaders
//
//  Created by vijay verma on 21/12/23.
//  Rough Playground for idea testing

import SwiftUI

struct GradientTest: View {
    @State private var circlePosition: CGFloat = 0 // Initial position
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: 100, height: 100)
                .zIndex(4)
            Rectangle()
                .foregroundStyle(.blue)
                .frame(width: 100, height: 100)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        }
        VStack {
            Spacer()
            
            // Circle view that moves horizontally
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .offset(x: circlePosition, y: 0) // Use offset to move the circle
                
            Spacer()
            
            // Button to trigger the animation
            Button("Move Circle") {
                withAnimation(.linear(duration: 2)) {
                    self.circlePosition = 200 // Set the final position
                }
            }
            
            Spacer()
        }
    }
}



#Preview {
    GradientTest()
}
