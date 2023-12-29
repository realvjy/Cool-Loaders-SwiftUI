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


struct TappableAreaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
    }
}
struct ContentView: View {
    // Example width and height for ellipses
    let ellipseDimensions: [(width: CGFloat, height: CGFloat)] = [(20, 20), (20, 20), (20, 20), (20, 20), (20, 20)]
    @State private var refreshID = UUID()
    // Example colors for ellipses
    let ellipsesColors: [Color] = [.red, .blue, .green, .yellow, .white]
    @StateObject var refreshManager = RefreshManager.shared
    @State private var shouldRerender = true
    @State private var selection: Int? = nil
    
    // State variables to manage current index, offset, and animation state
    @State private var currentIndex = 0
    @State private var offset: CGFloat = 0
    @State private var tappedArea: String = ""
    @State private var shouldScrollToBottom = false
    @State private var trackTapped = false
    @State private var visibleEllipses = 5 // Default number of visible ellipses
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let safeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        let usableScreenHeight = screenHeight - safeAreaHeight
        let cardHeight:CGFloat = 180
        
        ZStack{
            
            
            
            NavigationView {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 20){
                        HStack(spacing: 20){
                            ZStack{
                                LoaderLogoView(
                                    gOpacity: 1,
                                    size: 0.8,
                                    opacity: 1
                                )
                            }.frame(width: abs(screenWidth - 20), height: 80)
                        }.frame(width: screenWidth, height: 80)
                        HStack(spacing: 20){
                            NavigationLink(destination: CustomNavigationView(destinationView: Ring().id(refreshID), title: "Ring").id(refreshID)) {
                                ZStack{
                                    Ring()
                                        .scaleEffect(0.5)
                                        .frame(width: 300, height: 300)
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                            }
                            NavigationLink(destination: CustomNavigationView(destinationView: Rings().id(refreshID), title: "Rings").id(refreshID)) {
                                ZStack {
                                    Rings()
                                        .scaleEffect(0.4)
                                        .frame(width: 300, height: 300)
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                            }
                        }.frame(width: screenWidth, height: cardHeight)
                        HStack(spacing: 20){
                            NavigationLink(destination: CustomNavigationView(destinationView: Space().id(refreshID), title: "Space").id(refreshID)) {
                                ZStack{
                                    Space()
                                        .scaleEffect(0.5)
                                        .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                            }
                            NavigationLink(destination: CustomNavigationView(destinationView: Wheel().id(refreshID), title: "Wheel").id(refreshID)) {
                                ZStack {
                                    Wheel()
                                        .scaleEffect(0.48)
                                        .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                            }
                        }.frame(width: screenWidth, height: cardHeight)
                        
                        HStack(spacing: 20){
                            NavigationLink(destination: CustomNavigationView(destinationView: Track().navigationBarBackButtonHidden(true), title: "Track")) {
                                ZStack{
                                    Track()
                                        .scaleEffect(0.48).frame(width: 300, height: 300)
                                    
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                            }
                            NavigationLink(destination: CustomNavigationView(destinationView: Leaf().id(refreshID), title: "Leaf").id(refreshID) ) {
                                ZStack{
                                    
                                        Leaf()
                                            .scaleEffect(0.58).frame(width: 250, height: 300)
                                   
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                            }
                        }.frame(width: screenWidth, height: cardHeight)
                        
                        HStack{
                            NavigationLink(destination: CustomNavigationView(destinationView: Bar().id(refreshID), title: "Bar").id(refreshID) ) {
                                ZStack{
                                    Bar()
                                        .scaleEffect(1)
                                        .frame(width: 400, height: 300)
                                }.frame(width: screenWidth, height: cardHeight)
                            }
                        }.frame(width: abs(screenWidth - 20), height: 80)
                            .overlay{
                                RoundedRectangleStyle()
                            }
                        Spacer(minLength: 20)
                        HStack{
                            ZStack{
                                VStack{
                                    Text("Designed and Developed by").font(.system(size: 12)).opacity(0.5)
                                    Image("realvjy")
                                        .opacity(1)
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                    HStack{
                                        Link("Twitter", destination: URL(string: "https://www.x.com/realvjy")!)
                                            .font(.system(size: 15)).opacity(0.9)
                                                    .padding(10)
                                        Link("Github", destination: URL(string: "https://www.github.com/realvjy")!)
                                            .font(.system(size: 15)).opacity(0.9)
                                                    .padding(10)
                                    }
                                }
                            }.frame(width: screenWidth, height: 300)
                        }.frame(width: abs(screenWidth - 20), height: 80)
                            
                        
                    }
                    .navigationBarBackButtonHidden(true)
                    .background(Color("LaunchScreenBackgroundColor"))
                }
                .background(Color("LaunchScreenBackgroundColor"))
                
            }
            
            .onReceive(refreshManager.$shouldRefresh) { _ in
                
                print("Main view refreshed")
                
            }
        }
        .onAppear(){
            refreshID = UUID()
        }
        .background(Color("LaunchScreenBackgroundColor"))
        .ignoresSafeArea()
    }
}



#Preview {
    ContentView().preferredColorScheme(.dark) // Set the color scheme to dark mode
}

class RefreshManager: ObservableObject {
    static let shared = RefreshManager()
    
    @Published var shouldRefresh = false
    
    func toggleRefresh() {
        shouldRefresh.toggle()
    }
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
