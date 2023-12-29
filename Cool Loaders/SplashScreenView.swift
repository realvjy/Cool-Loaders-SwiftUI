//
//  SplashScreenView.swift
//  Cool Loaders
//
//  Created by vijay verma on 26/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 1.0
    @State private var opacity = 1.0
    @State private var rOpacity = 0.0
    @State private var gOpacity = 0.0
    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            GeometryReader { geometry in
                VStack {
                    ZStack{

                        VStack{
                            LoaderLogoView(
                                        gOpacity: gOpacity,
                                        size: size,
                                        opacity: opacity
                            )
                            Image("realvjy")
                                .opacity(rOpacity)
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .padding(.bottom, 40)
                        }
                        
                    }
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 1.4).repeatForever()) {
                            self.gOpacity = self.gOpacity == 1.0 ? 0.6 : 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 1.0
                                self.opacity = 1.0
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                            withAnimation(.easeIn(duration: 0.2)) {
                                self.rOpacity = 1.0
                            }
                        }
                        
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color("LaunchScreenBackgroundColor")) // Optional: Add a background color
                
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView().preferredColorScheme(.dark)
}



struct LoaderLogoView: View {
    let gOpacity: Double
    let size: CGFloat
    let opacity: Double
//    let rOpacity: Double
    
    var body: some View {
        ZStack {
            ZStack {
                Ellipse()
                    .frame(width: 120, height: 12)
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(UIColor(hex: "FFA800")), location: 0.00),
                                Gradient.Stop(color: Color(UIColor(hex: "FF5252")), location: 0.51),
                                Gradient.Stop(color: Color(UIColor(hex: "FF00C7 ")), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: -0.15, y: 0.78),
                            endPoint: UnitPoint(x: 0.73, y: 0.33)
                        )
                    )
                
                    .blur(radius: 16)
                    .offset(x: -60)
                Ellipse()
                    .frame(width: 110, height: 20)
                    .foregroundStyle(LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(UIColor(hex: "0085FF")), location: 0.00),
                            Gradient.Stop(color: Color(UIColor(hex: "9E00FF ")), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: -0.15, y: 0.78),
                        endPoint: UnitPoint(x: 0.73, y: 0.33)
                    ))
                    .blur(radius: 10)
                    .offset(x:-20)
                Ellipse()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20)
                    .foregroundStyle(LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(UIColor(hex: "EBFF00")), location: 0.00),
                            Gradient.Stop(color: Color(UIColor(hex: "FF4D00")), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: -0.15, y: 0.78),
                        endPoint: UnitPoint(x: 0.73, y: 0.33)
                    ))
                    .offset(x:20)
                    .blur(radius: 10)
                Ellipse()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 12)
                    .foregroundStyle(LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(UIColor(hex: "00FF66")), location: 0.00),
                            Gradient.Stop(color: Color(UIColor(hex: "0085FF")), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: -0.15, y: 0.78),
                        endPoint: UnitPoint(x: 0.73, y: 0.33)
                    ))
                    .blur(radius: 10)
                    .offset(x:80)
            }
            .opacity(gOpacity)
            .blur(radius: 26)
            .offset(y: 10)
            .scaleEffect(size)
            VStack {
                Spacer()
                Image("cool-loaders")
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(size)
                    .opacity(opacity)
                Spacer()
            }
            
        }
    }
}
