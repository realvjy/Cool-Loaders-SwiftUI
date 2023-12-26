//
//  ContentView.swift
//  Cool Loaders
//
//  Created by vijay verma on 20/12/23.
//

import SwiftUI
import MetalKit

class TimerManager: ObservableObject {
    @Published var displayValue = 0.0
    @Published var showvalue = false
    var value = 0.8
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self]timer in
            if showvalue {
                if self.displayValue < self.value {
                    self.displayValue += 0.01
                } else {
                    timer.invalidate()
                }
            } else {
                if self.displayValue > 0 {
                    self.displayValue -= 0.01
                } else{
                    timer.invalidate()
                }
            }
        }
    }
}




struct ContentView: View {
    // Example width and height for ellipses
    let ellipseDimensions: [(width: CGFloat, height: CGFloat)] = [(20, 20), (20, 20), (20, 20), (20, 20), (20, 20)]
    
    // Example colors for ellipses
    let ellipsesColors: [Color] = [.red, .blue, .green, .yellow, .white]
    
    // State variables to manage current index, offset, and animation state
    @State private var currentIndex = 0
    @State private var offset: CGFloat = 0
    
    @State private var shouldScrollToBottom = false
    @State private var visibleEllipses = 5 // Default number of visible ellipses
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let safeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        let usableScreenHeight = screenHeight - safeAreaHeight
        ZStack{
//            Color("LaunchScreenBackgroundColor")
            NavigationView {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 10){
                        HStack{
                            ZStack{
                                LoaderLogoView(gOpacity: 1, size: 0.8, opacity: 1)
                                //                            Ring()
                                //                                .scaleEffect(0.4)
                                //                                .frame(width: screenWidth / 2)
                            }
                        }
                        .frame(width: screenWidth, height: 100)
                        Spacer()
                        HStack(spacing: 10){
                            ZStack{
                                Rings()
                                    .scaleEffect(0.37)
                                    .frame(width: screenWidth / 2, height: 200)
                            }.frame(width: abs(screenWidth / 2 - 20), height: 200)
                            .overlay{
                                RoundedRectangleStyle()
                            }
                            ZStack{
                                Ring()
                                    .scaleEffect(0.5)
                                    .frame(width: abs(screenWidth / 2 - 20), height: 200)
                                
                            }
                            .overlay{
                                RoundedRectangleStyle()
                            }
                            .frame(width: abs(screenWidth / 2 - 20), height: 200)
                        }
                        .frame(width: screenWidth, height: 200)
                        Spacer()
                        HStack{
                            ZStack{
                                Space()
                                    .scaleEffect(0.5)
                                    .frame(width: screenWidth / 2, height: 300)
                            }.frame(width: abs(screenWidth / 2 - 20), height: 200)
                            .overlay{
                                RoundedRectangleStyle()
                            }
                            .frame(width: abs(screenWidth / 2 - 20), height: 200)
     
                            ZStack{
                                Wheel()
                                    .scaleEffect(0.4)
                                    .frame(width: screenWidth / 2, height: 300)
                            }.frame(width: abs(screenWidth / 2 - 20), height: 200)
                            .overlay{
                                RoundedRectangleStyle()
                            }
                            .frame(width: abs(screenWidth / 2 - 20), height: 200)
                        }.frame(width: screenWidth, height: 200)
                        Spacer()
                        HStack{
                            ZStack{
                                Track()
                                    .scaleEffect(0.5)
                                    .frame(width: screenWidth / 2, height: 300)
                            }.frame(width: abs(screenWidth / 2 - 20), height: 200)
                                .overlay{
                                    RoundedRectangleStyle()
                                }
                                .frame(width: abs(screenWidth / 2 - 20), height: 200)
                            
                            ZStack{
                                Leaf()
                                    .scaleEffect(0.4)
                                    .frame(width: screenWidth / 2, height: 300)
                            }.frame(width: abs(screenWidth / 2 - 20), height: 200)
                                .overlay{
                                    RoundedRectangleStyle()
                                }
                        }.frame(width: screenWidth, height: 200)
                        Spacer()
                        HStack{
                            ZStack{
                                Bar()
                                    .scaleEffect(1)
                                    .frame(width: screenWidth - 20, height: 100)
                            }
                        }
                            .overlay{
                                    RoundedRectangleStyle()
                                }
                            .frame(width: screenWidth, height: 200)
                    }
                    //.padding(20)
                    .background(Color("LaunchScreenBackgroundColor"))
                    .frame(minHeight: usableScreenHeight)
    //                .background(.green) /// debug
                }
                .background(Color("LaunchScreenBackgroundColor"))
                
                //.edgesIgnoringSafeArea(.all)
                
            }
        }

        
        .background(Color("LaunchScreenBackgroundColor"))
        .ignoresSafeArea()
    }
}



#Preview {
    ContentView().preferredColorScheme(.dark) // Set the color scheme to dark mode
}



struct Card: View {
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 200, height: 150)
            .cornerRadius(10)
    }
}


struct NumValue: View {
    var displayedValue = 0.0
    var color : Color
    var body: some View{
        Text("\(Int(displayedValue * 100))%")
            .bold()
            .font(.largeTitle)
            .foregroundStyle(color)
    }
}
