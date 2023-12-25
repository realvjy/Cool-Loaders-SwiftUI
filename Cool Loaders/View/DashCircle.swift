//
//  DashCircle.swift
//  Cool Loaders
//
//  Created by vijay verma on 21/12/23.
//

import SwiftUI

struct DashCircle: View {
    @ObservedObject var tm = TimerManager()
    var body: some View {
        ZStack{
            Color(UIColor(hex: "28282C"))
            ZStack{
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 20, dash: [3, 4.5]))
                    .frame(width: 200, height: 200)
                Circle()
                    .trim(from: 0, to: tm.showvalue ? tm.value : 0)
                    .stroke(style: StrokeStyle(lineWidth: 20, dash: [3, 4.5]))
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color(UIColor(hex: "FE512B")))
                Circle()
                    .trim(from: 0, to: tm.showvalue ? tm.value : 0)
                    .stroke(style: StrokeStyle(lineWidth: 20, dash: [3, 4.5]))
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color(UIColor(hex: "FE512B")))
                    .blur(radius: 15)
            }
            .rotationEffect(.degrees(-90))
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
    DashCircle().environmentObject(TimerManager())
}
