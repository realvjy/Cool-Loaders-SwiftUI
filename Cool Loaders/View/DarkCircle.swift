//
//  DarkCircle.swift
//  Cool Loaders
//
//  Created by vijay verma on 21/12/23.
//

import SwiftUI

struct DarkCircle: View {
   @ObservedObject var tm = TimerManager()
    var body: some View {
        ZStack{
            Color(UIColor(hex: "282830"))
            Circle()
                .stroke(lineWidth: 20)
                .frame(width: 200, height: 200)
                .blur(radius: 10)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.07), .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .offset(x: -10, y: -10)
            Circle()
                .stroke(lineWidth: 20)
                .frame(width: 200, height: 200)
                .blur(radius: 10)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .offset(x: 8, y: 8)
            Circle()
                .stroke(lineWidth: 30)
                .frame(width: 200, height: 200)
                .foregroundColor(Color(UIColor(hex: "282830")))
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 150, height: 150)
                .blur(radius: 5)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            Circle()
                .stroke(lineWidth: 10)
                .frame(width: 150, height: 150)
                .blur(radius: 5)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .black.opacity(0.7), .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
            Circle()
                .trim(from: 0, to: tm.showvalue ? tm.value : 0)
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            NumValue(displayedValue: tm.displayValue, color: .white)
        }
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation(.spring().speed(0.2)){
                tm.showvalue.toggle()
                tm.startTimer()
                }
            }
    }
}

#Preview {
    DarkCircle()
        .environmentObject(TimerManager())
}
