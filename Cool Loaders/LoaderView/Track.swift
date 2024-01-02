//
//  Track.swift
//  Cool Loaders
//
//  Created by vijay verma on 25/12/23.
//

import SwiftUI


struct TrackGradient: View {
    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color(UIColor(hex: "#FF8A00")), location: 0.0),
        Gradient.Stop(color: Color(UIColor(hex: "#E01949")), location: 0.14),
        Gradient.Stop(color: Color(UIColor(hex: "#A129AC")), location: 0.33),
        Gradient.Stop(color: Color(UIColor(hex: "#2F82FF")), location: 0.50),
        Gradient.Stop(color: Color(UIColor(hex: "#1FDEB0")), location: 0.60),
        Gradient.Stop(color: Color(UIColor(hex: "#65B400")), location: 0.82),
        Gradient.Stop(color: Color(UIColor(hex: "#FFB800")), location: 0.90),
        Gradient.Stop(color: Color(UIColor(hex: "#FF8A00")), location: 0.98),
    ])
    var body: some View {
        Rectangle()
            .frame(width: 400, height: 400)
            .foregroundStyle(
                AngularGradient(gradient: gradient,
                                center: .center)
                
            )
    }
}

struct TrackBall: View {
    let gradient = Gradient(stops: [
        Gradient.Stop(color: Color(UIColor(hex: "#FF8A00")), location: 0.0),
        Gradient.Stop(color: Color(UIColor(hex: "#E01949")), location: 0.14),
        Gradient.Stop(color: Color(UIColor(hex: "#A129AC")), location: 0.33),
        Gradient.Stop(color: Color(UIColor(hex: "#2F82FF")), location: 0.50),
        Gradient.Stop(color: Color(UIColor(hex: "#1FDEB0")), location: 0.60),
        Gradient.Stop(color: Color(UIColor(hex: "#65B400")), location: 0.82),
        Gradient.Stop(color: Color(UIColor(hex: "#FFB800")), location: 0.90),
        Gradient.Stop(color: Color(UIColor(hex: "#FF8A00")), location: 0.98),
    ])
    
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 24, height: 24)
                .blur(radius: 2.0)
                .foregroundColor(Color(UIColor(hex: "FFA800")))
                .offset(x:3, y:8)
                .blendMode(.hardLight)
            Circle()
                .frame(width: 20, height: 20)
                .blur(radius: 5.0)
                .foregroundColor(Color(UIColor(hex: "05FF00")).opacity(0.8))
                .offset(x: -2, y:8)
                .blendMode(.hardLight)
            ZStack{
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                Circle()
                    .stroke(lineWidth: 11)
                    .frame(width: 34, height: 34)
                    .blur(radius: 3.5)
                    .offset(y:-5)
                    .foregroundColor(Color(UIColor(hex: "0094FF")))
                Circle()
                    .frame(width: 12, height: 12)
                    .blur(radius: 2)
                    .offset(y:-8)
                    .foregroundColor(Color(UIColor(hex: "FFF500")))
                
                Circle()
                    .stroke(lineWidth: 9)
                    .frame(width: 34, height: 34)
                    .blur(radius: 3)
                    .offset(y:-2.5)
                    .foregroundColor(Color(UIColor(hex: "FF5CEF")))
                
                Circle()
                    .stroke(lineWidth: 9)
                    .frame(width: 38, height: 38)
                    .blur(radius: 1)
                    .offset(y:-2)
                    .foregroundColor(Color(UIColor(hex: "FFCA64")))
                Circle()
                    .stroke(lineWidth: 9)
                    .frame(width: 38, height: 38)
                    .blur(radius: 0.5)
                    .offset(y:1.5)
                    .blendMode(.overlay)
                    .foregroundColor(Color(UIColor(hex: "FFFFFF")))
                ZStack{
                    Ellipse()
                        .frame(width: 16, height: 10)
                        .offset(y:-6)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.9), .clear]), startPoint: .top, endPoint: .bottom))
                        .blendMode(.colorDodge)
                }
            }.mask{
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            
        }
        .offset(x:0, y:45)
        
    }
}


struct MainCircle: View {
    let originalWidthCircle1: CGFloat = 220
    let originalWidthCircle2: CGFloat = 100
    
    var geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
           
                .frame(width: geometry.calculateSize(originalWidth: originalWidthCircle1).width)
                .offset(geometry.calculateOffset(x: 0, y: 0))

            
            Circle()
                .fill(Color.blue)
                .frame(width: geometry.calculateSize(originalWidth: originalWidthCircle2).width)

        }
    }
    
    
}

struct Track: View {
    @State private var rotationDegrees: Double = 180
    @State private var offsetX: CGFloat = 64
    @State private var animate = false
    @State private var timer: Timer?
    @State private var reverseRotation = false
    @State private var previousRotationDegrees: Double = 0 // Store previous rotation
    @State private var autoReverse = false
    @State private var isForwardRotation = true

    
    let start = Date()
    
    
    var body: some View {
        ZStack{
            //            Color(.red) //for debug
            ZStack{
                ZStack{
                    TrackGradient()
                    RoundedRectangle(cornerRadius: 45.0)
                        .stroke(lineWidth: 14)
                        .frame(width: 222, height: 90)
                        .foregroundColor(.white)
                        .blur(radius: 5.0)
                        .blendMode(.overlay)
                    
                    RoundedRectangle(cornerRadius: 45.0)
                        .stroke(lineWidth: 9)
                        .frame(width: 185, height: 50)
                        .offset(x:0, y:-2)
                        .foregroundColor(.black).opacity(2)
                        .blur(radius: 5.0)
                        .blendMode(.multiply)
                    RoundedRectangle(cornerRadius: 45.0)
                        .stroke(lineWidth: 6)
                        .frame(width: 222, height: 90)
                        .foregroundColor(.white).opacity(0.6)
                        .blur(radius: 2.0)
                        .blendMode(.overlay)
                }
                .mask{
                    RoundedRectangle(cornerRadius: 45.0)
                        .stroke(lineWidth: 30)
                        .frame(width: 222, height: 90)
                        .foregroundColor(.red)
                }
            }
            
            TrackBall()
                .frame(width: 10, height: 100)
                .rotationEffect(.degrees(rotationDegrees))
                .offset(x: offsetX, y: 0)
  
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                animateStep3() // starting postion from stept 4
            }
        }
        .onDisappear {
            cleanUpTimer()
        }

        //.background(Color("LaunchScreenBackgroundColor"))
        .ignoresSafeArea()
    }
    
    
    
    func animateSequence() {
        
        animateStep1()
    }
    
    func animateStep1() {
        
        withAnimation(Animation.linear(duration: 1.0)) {
            self.rotationDegrees = 180
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateStep2()
        }
    }
    
    func animateStep2() {
        withAnimation(Animation.linear(duration: 1.0)) {
            self.offsetX = 64
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateStep3()
        }
    }
    
    func animateStep3() {
        withAnimation(Animation.linear(duration: 1.0)) {
            self.rotationDegrees = 360
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateStep4()
        }
    }
    
    func animateStep4() {
        withAnimation(Animation.linear(duration: 1.0)) {
            self.offsetX = -64
        }
        self.rotationDegrees = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateSequence()
            
        }
    }
    
    // Invalidate timer when view disappears to avoid memory leaks
    func cleanUpTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // Call cleanUpTimer when the view disappears
    func cleanUpTimerOnDisappear() {
        cleanUpTimer()
    }
}

#Preview {
    Track().preferredColorScheme(.dark)
    
}
