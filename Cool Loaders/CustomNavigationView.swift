//
//  CustomNavigationView.swift
//  Cool Loaders
//
//  Created by vijay verma on 29/12/23.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {
    var destinationView: Content
    var title: String
    
    init(destinationView: Content, title: String) {
        self.destinationView = destinationView
        self.title = title
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    destinationView
                        .navigationBarTitle("") // Hides the default title
                        .navigationBarHidden(true) // Hides the default navigation bar
                        .navigationBarBackButtonHidden(true)
                }.frame(width: geometry.size.width, height:  geometry.size.height)
               
                // Custom navigation bar with back button
                ZStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geometry.size.width, height: 35)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(UIColor(hex: "F5F2E4")), location: 0.10),
                                        Gradient.Stop(color: Color(UIColor(hex: "FFFFFF")), location: 0.43),
                                        Gradient.Stop(color: Color(UIColor(hex: "343434")), location: 0.80),
                                    ],
                                    startPoint: UnitPoint(x: 1.38, y: -0.24),
                                    endPoint: UnitPoint(x: 1.38, y: 0.99)
                                )).mask{
                                    Text(title).font(.system(size: 24).bold()).tracking(-0.2)
                                }
                        
                    }
                }
                .frame(width: geometry.size.width, height: 200)
                .alignmentGuide(.bottom) { _ in geometry.size.height / 2 }
                .offset(y: geometry.size.height / 2 - 100) // Offsets the rectangle to the bottom
            }
        }
        .background(Color("LaunchScreenBackgroundColor"))
        .ignoresSafeArea()
        
    }
}

#Preview {
    CustomNavigationView(destinationView: AnyView(Ring()), title: "Ring").preferredColorScheme(.dark)
}
