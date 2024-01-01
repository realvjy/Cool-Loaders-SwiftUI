//
//  Wheel.swift
//  Cool Loaders
//
//  Created by vijay verma on 22/12/23.
//

import SwiftUI

struct WheelGradient: View {
    var radius: CGFloat = 160
    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color(UIColor(hex: "#D1D52A")), location: 0.0),
        Gradient.Stop(color: Color(UIColor(hex: "#D1D52A")), location: 0.14),
        Gradient.Stop(color: Color(UIColor(hex: "#A9D62A")), location: 0.20),
        Gradient.Stop(color: Color(UIColor(hex: "#2A7596")), location: 0.32),
        Gradient.Stop(color: Color(UIColor(hex: "#335AE5")), location: 0.40),
        Gradient.Stop(color: Color(UIColor(hex: "#492DFF")), location: 0.52),
        Gradient.Stop(color: Color(UIColor(hex: "#BE2AD6")), location: 0.58),
        Gradient.Stop(color: Color(UIColor(hex: "#F52349")), location: 0.72),
        Gradient.Stop(color: Color(UIColor(hex: "#D62A36")), location: 0.96)
    ])
    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.75)
            .stroke(style: StrokeStyle(lineWidth: 64, lineCap: .round))
            .rotationEffect(.degrees(180))
            .frame(width: radius)
            .foregroundStyle(
                AngularGradient(gradient: gradient,
                                center: .center)
                
            )
            .rotationEffect(.degrees(-90))
    }
}

struct Wheel: View {
    @State private var circleRotation: Double = 0.0
    let gradient = Gradient(stops: [
        Gradient.Stop(color: .red.opacity(0), location: 0.00),
        Gradient.Stop(color: .red.opacity(0.3), location: 0.14),
        Gradient.Stop(color: .red.opacity(0.44), location: 0.20),
        Gradient.Stop(color: .red.opacity(0.58), location: 0.35),
        Gradient.Stop(color: .red.opacity(0.58), location: 0.40),
        Gradient.Stop(color: .red.opacity(0.7), location: 0.53),
        Gradient.Stop(color: .red, location: 0.64),
        Gradient.Stop(color: .black, location: 0.82),
        Gradient.Stop(color: .clear, location: 0.92)
    ])
    
    var body: some View{
        ZStack{
            GeometryReader { geometry in
                ZStack{
                    ZStack{
                        Circle()
                            .fill(Color(UIColor(hex: "D8FFFF")))
                            .frame(width: 240)
                    }
                    //main animated ring
                    ZStack{
                        Circle()
                            .fill(.red)
                            .frame(width: 55)
                            .offset(x: 80, y: 10)
                            .blur(radius: 12)
                        ZStack{
                            WheelGradient()
                            Circle()
                                .fill(Color(UIColor(hex: "DC16FC")).opacity(0.8))
                                .frame(width: 80)
                                .blur(radius: 8)
                                .offset(x: 70, y: -36)
                            Circle()
                                .trim(from: 0, to: 0.75)
                                .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round))
                                .frame(width: 160)
                                .blur(radius: 16.0)
                                .rotationEffect(.degrees(90))
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .clear]), startPoint: .top, endPoint: .bottom))
                                .blendMode(.plusLighter)
                            Circle()
                                .trim(from: 0, to: 0.75)
                                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                .frame(width: 160)
                                .blur(radius: 6.0)
                                .rotationEffect(.degrees(90))
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .clear]), startPoint: .top, endPoint: .bottom))
                            
                        }
                        
                        //Mask
                        .mask{
        
                            Circle()
                                .trim(from: 0.0, to: 0.75)
                                .stroke(style: StrokeStyle(lineWidth: 64, lineCap: .round))
                                .rotationEffect(.degrees(180))
                                .frame(width: 160)
                                .foregroundStyle(
                                    AngularGradient(gradient: gradient,
                                                    center: .center)
        
                                )
                                .rotationEffect(.degrees(-90))
                        }
                        Circle()
                            .fill(Color(UIColor(hex: "DDA71C")).opacity(0.8))
                            .frame(width: 55)
                            .offset(x: 80, y: 0)
                            .blur(radius: 12)
                            .blendMode(.colorDodge)
                    }
                    .rotationEffect(Angle(degrees: circleRotation), anchor: .center)
                    .scaledToFit()
                    ZStack{
                        Circle()
                            .foregroundColor(Color(UIColor(hex:"0A0A0A")))
                            .frame(width: 80)
                            .offset(x:0, y:18)
                            .blur(radius: 24)
                            .blendMode(.multiply)
                        Circle()
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "FFFFFF")), Color(UIColor(hex: "747373"))]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 98)
                        Circle()
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "DAD8D8")), Color(UIColor(hex: "9D9D9D"))]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 90)
                        
                        //outer ring
                        ZStack{
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "000000")), Color(UIColor(hex: "747373"))]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 248)
                                .offset(x:0, y:12)
                                .blur(radius: 20)
                                .blendMode(.multiply)
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round))
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "FFFFFF")), Color(UIColor(hex: "747373"))]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 250)
                            
                        }
                    }
                }.frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
//                    .scaleEffect(0.2)
   
            }
   
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                rotateShapesContinuously(circleDuration: 1.4)
            }
        }
        .ignoresSafeArea()
        
    }
    func rotateShapesContinuously(circleDuration: Double) {
        withAnimation(Animation.linear(duration: circleDuration).repeatForever(autoreverses: false)) {
            circleRotation += 360.0
        }
    }
}

#Preview {
    Wheel().preferredColorScheme(.dark)
}
