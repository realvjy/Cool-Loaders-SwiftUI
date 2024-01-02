//
//  Space.swift
//  Cool Loaders
//
//  Created by vijay verma on 24/12/23.
//

import SwiftUI

struct Space: View {
    
    var shaderColor: Shader {
        let function = ShaderFunction(
            library: .default,
            name: "aqua"
        )
        let shader = Shader(function: function, arguments: [])
        return shader
    }
    
    @State private var circleRotation1: Double = 0.0
    @State private var circleRotation2: Double = 0.0
    
    
    let start = Date()
    @State private var xOffset = -500.0 // Start offscreen to the left

    var body: some View {
        ZStack{
  
                ZStack{

                    ZStack {
                        ZStack{
                            TimelineView(.animation) { context in
                                Rectangle()
                                    .foregroundStyle(.white)
                                    .starField(
                                        seconds: context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970
                                        
                                    )
                            }
                        }.frame(width: 400, height: 400)
                        
                        .mask{
                            Circle()
                                .stroke(lineWidth: 62)
                                .frame(width: 260)
                                .blur(radius: 34)
                        }
                    }
                    ZStack{
                        ZStack{
                            //stack 1
                            ZStack{
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "FFFFFF")))
                                    .frame(width: 196)
                                    .blur(radius: 18)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "0066FF")))
                                    .frame(width: 192)
                                    .blur(radius: 2)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "30CDFF")).opacity(0.5))
                                    .frame(width: 192)
                                    .blur(radius: 10)
                                    .blendMode(.softLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "FF8E6B")).opacity(0.8))
                                    .frame(width: 180)
                                    .blur(radius: 24)
                                    .offset(x:20)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "000AFF")).opacity(0.6))
                                    .frame(width: 182)
                                    .blur(radius: 22)
                                    .offset(x: 12, y: -12)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "00FF94")).opacity(0.6))
                                    .frame(width: 182)
                                    .blur(radius: 12)
                                    .offset(x: -16, y: 0)
                                    .blendMode(.overlay)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "A0FFF9")).opacity(0.8))
                                    .frame(width: 198)
                                    .blur(radius: 4)
                                    .offset(x: 4, y: 0)
                                    .blendMode(.colorDodge)
                            }
                            //stack 2
                            ZStack{
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "6BFFCA")).opacity(0.5))
                                    .frame(width: 200)
                                    .blur(radius: 20)
                                    .offset(x: -16, y: -8)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "4B5BED")).opacity(0.8))
                                    .frame(width: 198)
                                    .blur(radius: 12)
                                    .offset(x: 8, y: -12)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "2374EE")).opacity(0.8))
                                    .frame(width: 192)
                                    .blur(radius: 8)
                                    .blendMode(.overlay)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "FF5F05")).opacity(0.9))
                                    .frame(width: 190)
                                    .blur(radius: 8)
                                    .offset(x: -8, y: 0)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "FF8E6B")).opacity(0.9))
                                    .frame(width: 190)
                                    .blur(radius: 16)
                                    .offset(x: 8, y: 0)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "FFFFFF")).opacity(0.9))
                                    .frame(width: 192)
                                    .blur(radius: 8)
                                    .blendMode(.hardLight)
                                Circle()
                                    .foregroundColor(Color(UIColor(hex: "FFFFFF")).opacity(0.9))
                                    .frame(width: 196)
                                    .blur(radius: 2)
                                    .blendMode(.hardLight)
                            }
                        }
                        
                    }
                    .mask{
                        ZStack{
                            Circle()
                                .stroke(lineWidth: 70)
                                .foregroundColor(.red)
                                .frame(width: 258, height: 258)
                        }
                        
                        
                    }
                   
                //text{
                .overlay{
                    ZStack{
                        ZStack{
                            HStack(spacing: 0) {
                                GradientBar()
                                GradientBar()
                            }
                            .offset(x: xOffset)
                            .onAppear {
                                withAnimation(.linear(duration: 2).delay(0.1).repeatForever(autoreverses: false)) {
                                    xOffset = 500
                                }
                            }
                        }
                        .mask{
                            Text("space")
                                .foregroundStyle(.white)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 36 ))
                        }
                        
                    }
                }
                }
        }
        .background(.clear)
        .task {
          do {
            try await Task.sleep(for: .seconds(0.1))
            // missing code?
          } catch {
            print(error)
          }
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


extension View {
    func circleLoader(seconds: Double) -> some View {
        self
            .colorEffect(
                ShaderLibrary.default.circleLoader(.boundingRect, .float(seconds))
            )
    }
}

extension View {
    func starField(seconds: Double) -> some View {
        self
            .colorEffect(
                ShaderLibrary.default.starField(.boundingRect, .float(seconds))
            )
    }
}



#Preview {
    Space().preferredColorScheme(.dark)
}
