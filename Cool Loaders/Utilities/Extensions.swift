//
//  Extensions.swift
//
//  Created by vijay verma on 24/03/23.
//
import SwiftUI


extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


extension GeometryProxy {
    func calculateSize(originalWidth: CGFloat? = nil, originalHeight: CGFloat? = nil) -> CGSize {
            let widthToUse = originalWidth ?? self.size.width
            let heightToUse = originalHeight ?? self.size.height
            
            let widthRatio = widthToUse / self.size.width
            let heightRatio = heightToUse / self.size.height
            
            let ratio = min(widthRatio, heightRatio)
            
            let newWidth = self.size.width * ratio
            let newHeight = self.size.height * ratio
            
            return CGSize(width: newWidth, height: newHeight)
        }
    
    func calculateOffset(x: CGFloat, y: CGFloat) -> CGSize {
            let xOffset = x * size.width / self.size.width
            let yOffset = y * size.height / self.size.height
            return CGSize(width: xOffset, height: yOffset)
        }
    
    func calculateBlurRadius(proportionalTo width: CGFloat, compareTo: CGFloat? = nil) -> CGFloat {
            let normalizedWidth = width / (compareTo ?? 300) // Normalizing the width against a reference value
                
                // Calculate the proportional blur radius based on the normalized width and the size width
                return normalizedWidth * size.width
        }
    func calculateLineWidth(proportionalTo width: CGFloat, compareTo: CGFloat) -> CGFloat {
            return width * size.width / compareTo
        }
}

extension CGSize {
    init(_ size: (CGFloat, CGFloat)) {
        self.init(width: size.0, height: size.1)
    }
}

struct RoundedRectangleStyle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 0.4)
            .foregroundStyle(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(UIColor(hex: "626262")).opacity(0.2), location: 0.00),
                        Gradient.Stop(color: Color(UIColor(hex: "686868")).opacity(0.3), location: 0.5),
                        Gradient.Stop(color: Color(UIColor(hex: "686868")).opacity(0.1), location: 1.00),
                    ],
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 1)
                )
            )
    }
}
