//
//  Rings.swift
//  Cool Loaders
//
//  Created by vijay verma on 23/12/23.
//

import SwiftUI

struct StrokeCircleGradient: View {
    let widthScale: CGFloat
    let heightScale: CGFloat
    let lineWidth: CGFloat
    let blurRadius: CGFloat
    let colorHexTop: Color
    let colorHexBottom: Color
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 2 * 0.02 * min(geometry.size.width, geometry.size.height), lineCap: .round))
                    .frame(width: widthScale * geometry.size.width, height: heightScale * geometry.size.height)
                    .blur(radius: blurRadius)
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(UIColor(hex: "484848")), location: 0.00),
                                Gradient.Stop(color: Color(UIColor(hex: "0500FF")), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.15, y: 0.7),
                            endPoint: UnitPoint(x: 0.15, y: 0.21)
                        ))

                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1 * 0.01 * min(geometry.size.width, geometry.size.height), lineCap: .round))
                    .frame(width: widthScale * geometry.size.width, height: heightScale * geometry.size.height)
                    .blur(radius: 1)
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(UIColor(hex: "FFFFFF")), location: 0.00),
                                Gradient.Stop(color: Color(UIColor(hex: "FFFFFF")), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.15, y: 0.7),
                            endPoint: UnitPoint(x: 0.15, y: 0.21)
                        ))
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1 * 0.01 * min(geometry.size.width, geometry.size.height), lineCap: .round))
                    .blur(radius: 1)
                    .frame(width: widthScale * geometry.size.width, height: heightScale * geometry.size.height)
                    .foregroundStyle(.white)
                ZStack{
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: lineWidth * 0.01 * min(geometry.size.width, geometry.size.height), lineCap: .round))
                        .frame(width: widthScale * geometry.size.width, height: heightScale * geometry.size.height)
                        .blur(radius: blurRadius)
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: colorHexTop, location: 0.00),
                                    Gradient.Stop(color: colorHexBottom, location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.15, y: 0.8),
                                endPoint: UnitPoint(x: 0.15, y: 0.21)
                            ))
                }.blendMode(.plusLighter)
                ZStack{
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: lineWidth * 0.01 * min(geometry.size.width, geometry.size.height), lineCap: .round))
                        .frame(width: widthScale * geometry.size.width, height: heightScale * geometry.size.height)
                        .blur(radius: 2)
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: colorHexTop, location: 0.00),
                                    Gradient.Stop(color: colorHexBottom, location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.15, y: 0.8),
                                endPoint: UnitPoint(x: 0.15, y: 0.21)
                            ))
                }.blendMode(.plusLighter)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .mask{
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round))
                    .frame(width: widthScale * geometry.size.width, height: heightScale * geometry.size.height)
                    .blur(radius: 12)
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(UIColor(hex: "0500FF")), location: 0),
                                Gradient.Stop(color: Color(UIColor(hex: "0500FF")).opacity(0), location: 1),
                            ],
                            startPoint: UnitPoint(x: 0.15, y: 0.9),
                            endPoint: UnitPoint(x: 0.15, y: 0.3)
                        ))
            }
        }
    }
}


struct Rings: View {
    @State private var circleRotation1: Double = 0.0
    @State private var circleRotation2: Double = 0.0
    @State private var isReversed: Bool = false
    var body: some View{
        let gradient = Gradient(stops: [
            Gradient.Stop(color: Color(UIColor(hex: "#D1D52A")), location: 0.0),
            Gradient.Stop(color: Color(UIColor(hex: "#38D52A")), location: 0.14),
            Gradient.Stop(color: Color(UIColor(hex: "#A9D62A")), location: 0.20),
            Gradient.Stop(color: Color(UIColor(hex: "#2A7596")), location: 0.32),
            Gradient.Stop(color: Color(UIColor(hex: "#335AE5")), location: 0.40),
            Gradient.Stop(color: Color(UIColor(hex: "#492DFF")), location: 0.52),
            Gradient.Stop(color: Color(UIColor(hex: "#BE2AD6")), location: 0.58),
            Gradient.Stop(color: Color(UIColor(hex: "#F52349")), location: 0.72),
            Gradient.Stop(color: Color(UIColor(hex: "#D1D52A")), location: 0.96)
        ])
        ZStack{
//            Color("LaunchScreenBackgroundColor")
            ZStack{
                GeometryReader { geometry in
                    ZStack{

                        StrokeCircleGradient(widthScale: 1, heightScale: 1, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "FF5C00")), colorHexBottom: Color(UIColor(hex: "FF0000")))
                            .rotationEffect(Angle(degrees: circleRotation1), anchor: .center)
                        StrokeCircleGradient(widthScale: 0.98, heightScale: 0.98, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "FF008A")), colorHexBottom: Color(UIColor(hex: "0057FF")))
                            .rotationEffect(Angle(degrees: circleRotation2 - 80))
                        StrokeCircleGradient(widthScale: 0.92, heightScale: 0.92, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "61FF00")), colorHexBottom: Color(UIColor(hex: "00FFD1")))
                            .rotationEffect(Angle(degrees: circleRotation1 + 70), anchor: .center)
                        StrokeCircleGradient(widthScale: 0.96, heightScale: 0.96, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "FFF500")), colorHexBottom: Color(UIColor(hex: "FFF500")))
                            .rotationEffect(Angle(degrees: circleRotation2 + 20))
                        StrokeCircleGradient(widthScale: 0.90, heightScale: 0.90, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "0029FF")), colorHexBottom: Color(UIColor(hex: "00FFD1")))
                            .rotationEffect(Angle(degrees: circleRotation2 + 60), anchor: .center)
                        StrokeCircleGradient(widthScale: 0.80, heightScale: 0.80, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "00FFD1")), colorHexBottom: Color(UIColor(hex: "00FFD1")))
                            .rotationEffect(Angle(degrees: circleRotation1 - 20), anchor: .center)
                        StrokeCircleGradient(widthScale: 0.86, heightScale: 0.96, lineWidth: 1, blurRadius: 1, colorHexTop: Color(UIColor(hex: "FF005C")), colorHexBottom: Color(UIColor(hex: "FF0099")))
                            .rotationEffect(Angle(degrees: circleRotation2 - 120))
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 10 * 0.008 * min(geometry.size.width, geometry.size.height), lineCap: .round))
                            .frame(width: 0.9 * geometry.size.width, height: 0.9 * geometry.size.height)
                            .blur(radius: 12)
                            .rotationEffect(.degrees(90))
                            .foregroundStyle(
                                AngularGradient(gradient: gradient,
                                                center: .center)
                                
                            )
                            .rotationEffect(Angle(degrees: circleRotation1 ), anchor: .center)
                            .blendMode(.plusLighter)
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        rotateShapesContinuously(circleDuration1: 2.0, circleDuration2: 1.0)
                    }
                }
            }
            .frame(width: 300, height: 300)

        }
        .ignoresSafeArea()
    }
    
    func rotateShapesContinuously(circleDuration1: Double, circleDuration2: Double) {
        withAnimation(Animation.linear(duration: circleDuration1).repeatForever(autoreverses: false)) {
            circleRotation1 += 360.0
        }
        
        withAnimation(Animation.linear(duration: circleDuration2).repeatForever(autoreverses: false)) {
            circleRotation2 -= 360.0
        }
    }
}

#Preview {
    Rings()
}
