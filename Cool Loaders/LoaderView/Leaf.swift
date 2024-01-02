//
//  Leaf.swift
//  Cool Loaders
//
//  Created by vijay verma on 24/12/23.
// TODO logic

import SwiftUI

struct CircleLeaf: View {
    
    let width: CGFloat
    let height: CGFloat
    let color: Color
    let opacity: CGFloat
    var body: some View {
        let wFactor:CGFloat = width/200
        let hFactor:CGFloat = height/200
        ZStack{
            Color(color)
            Image("dot-pattern")
                .resizable()
                .frame(width: 180.0, height: 180.0).scaledToFill()
            Ellipse()
                .stroke(lineWidth: 0.5)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "FFFFFF")), Color(UIColor(hex: "747373"))]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 200 * wFactor, height: 200 * hFactor)
                .blur(radius: 0.2 )
                .blendMode(.overlay)
        }.mask{
            Ellipse()
                .foregroundColor(.black)
                .frame(width: width, height: height)
        }.opacity(opacity)
    }
}

struct Leaf: View {
    
    
    @State private var circles: [CircleData] = CircleData.circlesWithPosition()
    @State private var circles2: [CircleData] = CircleData.circlesWithPosition()
    
    
    
    let circleWidth: CGFloat = 10
    let moveDistance: CGFloat = 10
    let validPositions: [CGFloat] = [-10, 0, 10, 20]
    let validWidths: [CGFloat] = [20, 20, 15, 10]
    @State private var newPos: CGFloat = 0
    @State private var newOpacity: CGFloat = 0
    @State private var timer: Timer?
    @StateObject var refreshManager = RefreshManager.shared
    
    
    var body: some View {
        
        ZStack {
            ZStack{
                ForEach(circles.indices, id: \.self) { index in
                    ZStack {
                        CircleLeaf(width: circles[index].width, height: circles[index].height, color: Color(circles[index].color), opacity: circles[index].opacity)
                            .offset(x: circles[index].position)
                            .zIndex(CGFloat(circles[index].zIndex))
                            .scaleEffect(3)
                    }
                }
            }
            .offset(x: -48)
            .task {
              do {
                try await Task.sleep(for: .seconds(0.4))
                animateCircles(rev: false, cBool: true)
              } catch {
                print(error)
              }
            }
            
            ZStack{
                ForEach(circles2.indices, id: \.self) { index in
                    ZStack {
                        CircleLeaf(width: circles2[index].width, height: circles2[index].height, color: Color(circles2[index].color), opacity: circles2[index].opacity)
                            .offset(x: circles2[index].position)
                            .zIndex(CGFloat(circles2[index].zIndex))
                            .scaleEffect(3)
                    }
                    
                }
            }
            .task {
              do {
                try await Task.sleep(for: .seconds(0.4))
                animateCircles(rev: true, cBool: false)
              } catch {
                print(error)
              }
            }
            .offset(x: -48).scaleEffect(x: -1, y: 1)
            
            
        }
        .scaleEffect(1.8)
        .task {

            do {
              try await Task.sleep(for: .seconds(2))
              // missing code?
            } catch {
              print(error)
            }

        }
            .onDisappear {
                refreshManager.shouldRefresh = true
            }
        
    }
    
    func animateCircles(rev: Bool, cBool: Bool) {
        
        
        
        var index = 0
        
        while index < circles.count {
            
            //            let nextIndex = index+1 >= circles.count ? 0 : index+1
            
            
            
            if index < circles.count - 1 {
              withAnimation(Animation.linear(duration: 0.7)) {

                  if rev {
                      shiftLeft(cBool: cBool)
                  } else {
                      shiftRight(cBool: cBool)
                  }

              }

            }
            
            index += 1
            
        }
      Task { @MainActor in
        try await Task.sleep(for: .seconds(0.7))
        self.animateCircles(rev: rev, cBool: cBool)
      }

    }
    
    
    func resetLast(idx: Int) {
        print("inside reset")
        changeOpacity(idx: idx)
        
    }
    func shiftRight(cBool: Bool) {
        if cBool {
            guard !circles.isEmpty else { return }
            
            let lastElement = circles.removeLast()
            circles.insert(lastElement, at: 0)
            // Update zIndex after shifting
            for (index, _) in circles.enumerated() {
                circles[index].zIndex = index - 1 // trying to fix zindex no luck
            }
        } else {
            guard !circles2.isEmpty else { return }
            
            let lastElement = circles2.removeLast()
            circles2.insert(lastElement, at: 0)
            for (index, _) in circles2.enumerated() {
                circles2[index].zIndex = index - 1 // trying to fix zindex no luck
            }
        }
    }
    
    func shiftLeft(cBool: Bool) {
        if cBool{
            guard !circles.isEmpty else { return }
            
            let firstElement = circles.removeFirst()
            circles.append(firstElement)
            
            for (index, _) in circles.enumerated() {
                circles[index].zIndex = index - 1 // trying to fix zindex no luck
            }
        } else {
            guard !circles2.isEmpty else { return }
            
            let firstElement = circles2.removeFirst()
            circles2.append(firstElement)
            // Update zIndex after shifting
            for (index, _) in circles2.enumerated() {
                circles2[index].zIndex = index - 1 // trying to fix zindex no luck
            }
        }
    }
    
    func swapValues(at index: Int) {
        guard index >= 0, index < circles.count - 1 else {
            // Handle out of bounds or invalid index here
            return
        }
        
        circles.swapAt(index, index + 1)
    }
    
    func changeOpacity(idx: Int) {
      Task { @MainActor in
        try await Task.sleep(for: .seconds(2))
        self.circles[idx].opacity = 0
      }
    }
    func resetCircleProperties() {
        //        self.circles[idx].position = pos
        for index in circles.indices {
            circles[index].opacity = 1.0 // Reset opacity or any other properties you've changed during
        }
    }
    
    func animateLastCircle(withDelay delay: TimeInterval, index: Int, pos: CGFloat) {
      Task { @MainActor in
        try await Task.sleep(until: .now + .seconds(0.1),
                             tolerance: .microseconds(1),
                             clock: .continuous)
        self.circles[index].opacity = 0
        self.circles[index].position = pos
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
}

struct CircleData: Identifiable, Hashable {
    let id = UUID()
    var position: CGFloat
    var opacity: Double
    var color: String
    var width: CGFloat
    var height: CGFloat
    var zIndex: Int
    
    // Initializer with default parameter values
    init(position: CGFloat = 1, opacity: Double = 0, color: String = "lred", width: Double = 18, height: Double = 1.0, zIndex: Int = 0) {
        self.position = position
        self.opacity = opacity
        self.color = color
        self.width = width
        self.height = height
        self.zIndex = zIndex
    }
    
    
    
    static func circlesWithPosition() -> [CircleData] {
        let circles: [CircleData] = [
            CircleData(opacity: 0, color: "lred", width: 18, height: 1.0, zIndex: -1),
            CircleData(opacity: 0, color: "lred", width: 18, height: 18, zIndex: 0),
            CircleData(opacity: 1, color: "lred2", width: 14.0, height: 18, zIndex: 1),
            CircleData(opacity: 1, color: "lorange", width: 8.0, height: 18, zIndex: 2),
            CircleData(opacity: 1, color: "lyellow", width: 5.0, height: 18, zIndex: 3),
            CircleData(opacity: 1, color: "lyellow2", width: 2, height: 18, zIndex: 4),
            CircleData(opacity: 1, color: "lteal", width: 1, height: 18, zIndex: 5),
            CircleData(opacity: 0, color: "lteal", width: 1, height: 18, zIndex: 6)
        ]
        
        var circlesWithPositions = circles
        for index in circlesWithPositions.indices {
            circlesWithPositions[index].position = xOffsetForCircle(at: index, circlesI: circlesWithPositions)
            
        }
        return circlesWithPositions
    }
}


func xOffsetForCircle(at index: Int, circlesI: [CircleData]) -> CGFloat{
    
    var shift:CGFloat = 0
    var accumulatedPrevWidth: CGFloat = 0
    var accumulatedNextWidth: CGFloat = 0
    
    // Calculate accumulated previous width
    for i in 0..<index {
        accumulatedPrevWidth += getCenter(width: i == 0 ? 0 :  circlesI[i].width)
        
    }
    
    // Calculate accumulated next width
    for i in (index + 1)..<circlesI.count {
        accumulatedNextWidth += getCenter(width: circlesI[i].width)
    }
    
    // Calculate the offset for the first circle
    let firstCircleOffset = getCenter(width: circlesI.first!.width)
    
    // Calculate the offset for the second circle
    _ = getCenter(width: circlesI[1].width)
    
    // Calculate the adjusted position for the second circle
    var result = accumulatedPrevWidth - accumulatedNextWidth + shift + firstCircleOffset + circlesI.first!.width
    
    // Define the shift value based on the previous circle width
    let prevCircleWidth = index - 1 >= 0 ? getCenter(width: circlesI[index - 1].width) : 0
    let currentCircleWidth = getCenter(width: circlesI[index].width)
    
    // Calculate the overlap by taking the difference in widths
    let overlap = prevCircleWidth/2 - currentCircleWidth/2 - 35
    
    // Apply the overlap to the result to ensure circles overlap
    result += overlap
    
    var nextIndex = index+1 >= circlesI.count ? 0 : index+1
    var prevIndex = index-1 < 0 ? 0 : index-1
    
    
    return max(result, 0)
    
}

func getCenter(width: CGFloat) -> CGFloat {
    return width / 2
}

extension CircleData: Comparable {
    static func < (lhs: CircleData, rhs: CircleData) -> Bool {
        return lhs.position > rhs.position
    }
}

struct LeafPreview { // Example struct for holding the namespace
    @Namespace static var namespace
}

#Preview {
    //    Leaf(namespace: LeafPreview.namespace, show: .constant(true)).preferredColorScheme(.dark)
    Leaf().preferredColorScheme(.dark)
}
