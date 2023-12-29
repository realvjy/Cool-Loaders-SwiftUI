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
                        Gradient.Stop(color: Color(UIColor(hex: "626262")).opacity(0.3), location: 0.00),
                        Gradient.Stop(color: Color(UIColor(hex: "686868")).opacity(0.4), location: 0.5),
                        Gradient.Stop(color: Color(UIColor(hex: "686868")).opacity(0.1), location: 1.00),
                    ],
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 1)
                )
            )
    }
}


extension View {
    func customNavigationLink<Destination: View>(destination: @escaping () -> Destination, title: String) -> some View {
        NavigationLink(destination:
            CustomNavigationView(destinationView: AnyView(destination()), title: title)
        ) {
            self
        }
    }
}

extension View {
    func onTapGestureForced(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        self
            .contentShape(Rectangle())
            .onTapGesture(count:count, perform:action)
    }
}


//@Nick Bellucci solution ,

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        
        // remove left buttons (in case you added some)
         self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
         self.navigationItem.hidesBackButton = true
        
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
}
