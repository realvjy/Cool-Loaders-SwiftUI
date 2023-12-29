//
//  Bar.swift
//  Cool Loaders
//
//  Created by vijay verma on 22/12/23.
//

import SwiftUI

struct GradientBar: View {
    var body: some View {
        Rectangle()
            .frame(width: 1000, height: 150)
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [
                Color(UIColor(hex: "#4FDC4A")),
                Color(UIColor(hex: "#3FDAD8")),
                Color(UIColor(hex: "#2FC9E2")),
                Color(UIColor(hex: "#1C7FEE")),
                Color(UIColor(hex: "#5F15F2")),
                Color(UIColor(hex: "#BA0CF8")),
                Color(UIColor(hex: "#FB07D9")),
                Color(UIColor(hex: "#FF0000")),
                Color(UIColor(hex: "#FF9A00")),
                Color(UIColor(hex: "#D0DE21")),
                Color(UIColor(hex: "#4FDC4A")),
            ]), startPoint: .leading, endPoint: .trailing))

    }
}

struct Bar: View {
    @State var gradientColors: [Color] = [.red, .green, .blue]
    @State private var xOffset = -500.0 // Start offscreen to the left
    
    @State private var animationState = 1
    
    var body: some View {
        ZStack {
            //Base Track
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(UIColor(hex: "717171")))
                        .blur(radius: 4)
                        .frame(width: 288, height: 5)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor(hex: "FFFFFF")))
                        .frame(width: 275, height: 4)

                }.blur(radius: 3)
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(UIColor(hex: "FFFFFF")))
                        .frame(width: 275, height: 2)
                }
            }
            
            //Gradient Incoming
            ZStack{
                HStack(spacing: 0) {
                    GradientBar()
                    GradientBar()
                }
                .offset(x: xOffset)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                            xOffset = 500
                        }
                    }
                }
            }
            //Color masking
            .mask{
                RoundedRectangle(cornerRadius: 6)
                    .blur(radius: 10)
                    .frame(width: 318, height: 12)
            }
            .blendMode(.plusLighter)
   
            ZStack{
                Ellipse()
                    .fill(EllipticalGradient(gradient: .init(stops: [
                        Gradient.Stop(color: .white, location: 0.0),
                        Gradient.Stop(color: Color(UIColor(hex: "1d1d1d")).opacity(0.3), location: 0.8)
                    ])))
                    .frame(width: getSize(), height: 30)
                    .foregroundColor(.blue)
                    .blur(radius: 4)
                    .offset(x: getOffset())
                    .onAppear() {
                        performAnimation()
                    }
            }.blendMode(.plusLighter)
            ZStack{
                Ellipse()
                    .fill(EllipticalGradient(gradient: .init(stops: [
                        Gradient.Stop(color: .white, location: 0.0),
                        Gradient.Stop(color: Color(UIColor(hex: "1d1d1d")).opacity(0.3), location: 0.8)
                    ])))
                    .frame(width: 300, height: 10)
                    .blur(radius: 2)
            }.blendMode(.plusLighter)
            
        }
    }
    
    func getSize() -> CGFloat {
        switch animationState {
        case 1, 3:
            return 2
        case 2:
            return 310
        default:
            return 3
        }
    }
    
    func getOffset() -> CGFloat {
        switch animationState {
        case 1:
            return -140
        case 2:
            return 0
        case 3:
            return 145
        default:
            return -200
        }
    }
    func performAnimation() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.linear(duration: 0.2)) {
                self.animationState = 2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: 0.2)) {
                    self.animationState = 3
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        // Instantly transition to frame 1 without animation
                        self.animationState = 1
                        performAnimation() // Repeat the animation
                    }
                }
            }
        }
    }
    
}

#Preview {
    Bar().preferredColorScheme(.dark)
}
