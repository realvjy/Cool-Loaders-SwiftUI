//
//  CustomNavigationView.swift
//  Cool Loaders
//
//  Created by vijay verma on 29/12/23.
//

import SwiftUI




struct CustomNavigationView: View {

    
    
    let loaderType: LoaderType
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack{
        GeometryReader { geometry in
            
                ZStack{
                    Button(action: {
                        withAnimation{
                            onDismiss()
                        }
                    }){
                        ZStack {
                            loaderType.view
                                .frame(width: geometry.size.width, height:  geometry.size.height)
                        }}.frame(width: geometry.size.width, height:  geometry.size.height)
                        

                        //text
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
                                            Text(String(describing: loaderType).capitalized).font(.system(size: 24).bold()).tracking(-0.2)
                                        }
                                
                            }
                        }
                        .frame(width: geometry.size.width, height: 200)
                        .alignmentGuide(.bottom) { _ in geometry.size.height / 2 }
                        .offset(y: geometry.size.height / 2 - 100) // Offsets the rectangle to the bottom
                    }.frame(width: geometry.size.width, height:  geometry.size.height)
                }
        }.onAppear{
            print(loaderType)
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color("LaunchScreenBackgroundColor"))
        .ignoresSafeArea()
        
    }
    
    
    
    
}

#Preview {
    CustomNavigationView(loaderType: .bar, onDismiss: {})
        .preferredColorScheme(.dark)
}
