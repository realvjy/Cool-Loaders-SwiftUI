//
//  GradientTest.swift
//  Cool Loaders
//
//  Created by vijay verma on 21/12/23.
//

import SwiftUI

struct GradientTest: View {
    let colors: [Color] = [.red, .green, .blue, .yellow]

        @State private var fakeCardIndex = 1
        let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

        var body: some View {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(colors.indices, id: \.self) { index in
                        Rectangle()
                            .fill(colors[(index + fakeCardIndex) % colors.count])
                            .frame(width: geometry.size.width)
                    }
                }
                .offset(x: -geometry.size.width * CGFloat(fakeCardIndex))
                .animation(.easeInOut(duration: 0.5), value: fakeCardIndex)
                .onReceive(timer) { _ in
                    withAnimation {
                        self.fakeCardIndex += 1
                        if self.fakeCardIndex >= colors.count + 1 {
                            self.fakeCardIndex = 1
                        }
                    }
                }
            }
            .frame(height: 200)
            .clipped()
        }
}



#Preview {
    GradientTest()
}
