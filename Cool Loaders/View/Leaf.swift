//
//  Leaf.swift
//  Cool Loaders
//
//  Created by vijay verma on 24/12/23.
// TODO logic

import SwiftUI

struct CircleLeaf: View {
    let scaleW: CGFloat
    let scaleH: CGFloat
    let color: Color
    var body: some View {
        GeometryReader { geometry in
            Ellipse()
                .fill(color)
                .frame(width: 40 * scaleW, height: 40)
        }
    }
}


struct Leaf: View {
    var body: some View {
            VStack {
                CircleAnimationView()
                    .padding()
                    .frame(width: 200, height: 200) // Adjust size as needed
            }
        }
}

// Custom Ellipse shape
struct Ellipse: Shape {
    func path(in rect: CGRect) -> Path {
        // Creating an elliptical path
        return Path(ellipseIn: rect)
    }
}

struct CircleAnimationView: View {
    @State private var circles: [CircleData] = [
        CircleData(position: -10, opacity: 0, color: .red),
        CircleData(position: 0, opacity: 1, color: .green),
        CircleData(position: 10, opacity: 1, color: .blue),
        CircleData(position: 20, opacity: 1, color: .yellow)
    ]

    let circleWidth: CGFloat = 10
    let moveDistance: CGFloat = 10
    let validPositions: [CGFloat] = [-10, 0, 10, 20]
    @State private var newPos: CGFloat = 0
    @State private var newOpacity: CGFloat = 0
    @State private var timer: Timer?
    
    var body: some View {
            VStack {
                Text("Animating Circles")
                ZStack{
                    ForEach(circles.indices, id: \.self) { index in
                        Circle()
                            .foregroundColor(circles[index].color)
                            .frame(width: circleWidth, height: circleWidth)
                            .opacity(circles[index].opacity)
                            .offset(x: circles[index].position - 20)
                            .scaleEffect(4)
                    }
                }
                
            }
        VStack{
            Text("Circle Positions: \(circlePositionsText())")
            Text("Circle Opacity: \(circleOpacityText())")
            Text("Circle at -10: \(circleAtNegativeTenColor())")
            
        }.frame(width: 400)
            .onAppear {
                animateCircles()
            }
        }
    func animateCircles() {
            
                let lastCircle = circles.last!

                for i in 0..<circles.count {
                    print("Circle \(circles[i].position) and postions \(validPositions[i]) color \(circles[i].color)")

                    
                    switch circles[i].position {
                        case -10:
                            withAnimation(Animation.linear(duration: 1.0)) {
                                self.circles[i].position = 0
                                self.circles[i].opacity = 1
                            }
                        case 0:
                            withAnimation(Animation.linear(duration: 1.0)) {
                                self.circles[i].position += 10
                                self.circles[i].opacity = 1
                        }
                        case 10:
                            withAnimation(Animation.linear(duration: 1.0)) {
                                self.circles[i].position += 10
                                self.circles[i].opacity = 1
                        }
                        case 20:
                            // Ease out the animation towards position 10
                            withAnimation(Animation.easeOut(duration: 0.5)) {
                                self.circles[i].position += 5
                                self.circles[i].opacity = 0 // Set opacity to 0 for smooth disappearance
                            }
                            // Then reset to -10 with another animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.circles[i].position = -10
                                self.circles[i].opacity = 0
                            }
                        default:
                            withAnimation(Animation.linear(duration: 1.0)) {
                                self.circles[i].position = -10
                                self.circles[i].opacity = 0.0
                        }
                    }
                    print("Color for currrent is color \(circles[i].color) postion \(circles[i].position) \n\n")
                    
//                    if circles[i].position == -10 {
//                        circles[i].position = 0
//                    } else {
//                        circles[i].position = -10
//                    }
//                    if circles[i].position >= 0 && circles[i].position <= 20 {
//                        withAnimation(Animation.linear(duration: 1.0)) {
//                            circles[i].position += moveDistance
//                        }
//                        
//                    } else {
//                        circles[i].position = -10
//                    }
//                    if !validPositions.contains(circles[i].position) {
//                        circles[i].position = circles[i].position.truncatingRemainder(dividingBy: 30)
//                    }
//                    if circles[i].position == validPositions[0] {
//                        circles[i].opacity = 0
//                    } else {
//                        circles[i].opacity = 1
//                        
//                    }

                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.animateCircles()
//
//                }
//                if lastCircle.position >= CGFloat(validPositions.last ?? 0) {
//                    let lastCircleIndex = circles.endIndex - 1
//                    circles[lastCircleIndex].position = validPositions[0]
//                    circles[lastCircleIndex].opacity = 0
//                    circles.sort { $0.position < $1.position }
//                    
//                    print(circlePositionsText())
//                    print(circleOpacityText())
//                }
          
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.animateCircles()
        
                        }
        }

    
    func resetCircles() {
        for i in 0..<circles.count {
            circles[i].position = validPositions[i]
            circles[i].opacity = (i == 0) ? 0 : 1
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
    
    func circlePositionsText() -> String {
        var positionsText = ""
        for circle in circles {
            positionsText += "\(Int(circle.position)), color \(circle.color)) "
        }
        return positionsText
    }
    
    func circleOpacityText() -> String {
        var opacityText = ""
        for circle in circles {
            opacityText += "\(Int(circle.opacity)) "
        }
        return opacityText
    }

    func circleAtNegativeTenColor() -> String {
        if let negativeTenCircle = circles.first(where: { $0.position == -10 }) {
            return negativeTenCircle.color.description
        }
        return ""
    }
    
    func xOffsetForCircle(at position: CGFloat) -> CGFloat {
//        let index = validPositions.firstIndex(of: position) ?? 0
//        return CGFloat(index - 1) * circleWidth * 2
        print("postion - \(position)")
        return 0
    }
}

struct CircleData: Identifiable, Hashable {
    let id = UUID()
    var position: CGFloat
    var opacity: Double
    var color: Color
}


#Preview {
    Leaf().preferredColorScheme(.dark) // Set the color scheme to dark mode
}
