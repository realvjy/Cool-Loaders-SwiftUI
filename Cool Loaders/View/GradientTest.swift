//
//  GradientTest.swift
//  Cool Loaders
//
//  Created by vijay verma on 21/12/23.
//

import SwiftUI

struct GradientTest: View {
    @State private var circlePosition: CGFloat = 0 // Initial position
    
    var body: some View {
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
