//
//  Ring.swift
//  Cool Loaders
//
//  Created by vijay verma on 22/12/23.
//

import SwiftUI

struct GradientCircleBar: View {
    var radius: CGFloat = 220
    var body: some View {
        Circle()
            .stroke(lineWidth: 10)
            .frame(width: radius)
            .foregroundStyle(
                AngularGradient(
                    gradient: Gradient(colors: [
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
                    ]),
                    center: .center,startAngle: .degrees(0), endAngle: .degrees(360))
                
            )
    }
}

struct Ring: View {
    @State private var ellipseRotation: Double = 0.0
    @State private var circleRotation: Double = 0.0
    var body: some View{
        ZStack{
            //Base Track
//            Color(.red) // debug
            Color("LaunchScreenBackgroundColor")
                ZStack{
                    ZStack{
                        ZStack{
                            Circle()
                                .stroke(lineWidth: 5)
                                .fill(Color(UIColor(hex: "717171")))
                                .frame(width: 220)
                                .blur(radius: 4)
                            Circle()
                                .stroke(lineWidth: 4)
                                .fill(Color(UIColor(hex: "FFFFFF")))
                                .frame(width: 220)
                        }.blur(radius: 3)
                        ZStack{
                            Circle()
                                .stroke(lineWidth: 2)
                                .fill(Color(UIColor(hex: "FFFFFF")))
                                .frame(width: 220)
                        }
                    }
                    ZStack{
                        GradientCircleBar()
                            .blur(radius: 8)
                        GradientCircleBar()
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .blur(radius: 20)
                        
                    }
                    .blendMode(.plusLighter)
                    .rotationEffect(Angle(degrees: circleRotation), anchor: .center)
                    
                    //Rotation
                    ZStack{
                        ZStack{
                            Ellipse()
                                .fill(EllipticalGradient(gradient: .init(stops: [
                                    Gradient.Stop(color: .white, location: 0.0),
                                    Gradient.Stop(color: Color(UIColor(hex: "1d1d1d")).opacity(0.3), location: 0.8)
                                ])))
                                .blur(radius: 4)
                                .frame(width: 30, height: 90)
                                .offset(x: 110, y: 0)
                        }
                        .blendMode(.plusLighter)
                        ZStack{
                            Ellipse()
                                .fill(EllipticalGradient(gradient: .init(stops: [
                                    Gradient.Stop(color: .white, location: 0.0),
                                    Gradient.Stop(color: Color(UIColor(hex: "1d1d1d")).opacity(0.2), location: 0.8)
                                ])))
                                .blur(radius: 10)
                                .frame(width: 40, height: 120)
                                .offset(x: 115, y: 0)
                        }
                        .blendMode(.plusLighter)
                        
                    }
                    .offset(x:-5)
                    .rotationEffect(Angle(degrees: ellipseRotation), anchor: .center)
                    
                }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                rotateShapesContinuously(circleDuration: 12.0, ellipseDuration: 4.0)
            }
        }
        .ignoresSafeArea()
    }
    func rotateShapesContinuously(circleDuration: Double, ellipseDuration: Double) {
        withAnimation(Animation.linear(duration: circleDuration).repeatForever(autoreverses: false)) {
            circleRotation += 360.0
        }
        
        withAnimation(Animation.linear(duration: ellipseDuration).repeatForever(autoreverses: false)) {
            ellipseRotation += 360.0
        }
    }
}

#Preview {
    Ring().preferredColorScheme(.dark)
}
