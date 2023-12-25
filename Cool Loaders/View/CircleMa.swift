//
//  CircleMa.swift
//  Cool Loaders
//
//  Created by vijay verma on 21/12/23.
//

import SwiftUI

struct CircleMa: View {
    @ObservedObject var tm = TimerManager()
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 24)
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y:10)
            Circle()
                .stroke(lineWidth: 0.34)
                .frame(width: 175, height: 175)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                .overlay{
                    Circle()
                        .stroke(.black.opacity(0.1), lineWidth: 2)
                        .blur(radius: 5)
                        .mask{
                            Circle()
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            Circle()
                .trim(from: 0, to: tm.showvalue ? tm.value : 0)
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            NumValue(displayedValue: tm.displayValue, color: .black)
        }
        .onTapGesture {
            withAnimation(.spring().speed(0.2)){
                tm.showvalue.toggle()
                tm.startTimer()
                }
            }
        }
}

#Preview {
    CircleMa()
}
