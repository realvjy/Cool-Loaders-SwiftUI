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
class NavigationState: ObservableObject {
    @Published var isComingBackFromChild = false
}

struct TappableAreaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
    }
}
struct ContentView: View {
    @Namespace var namespace
    @State var show = false
    @State private var refreshCount = 0
    @State private var refreshID = UUID()
    // Example colors for ellipses
    let ellipsesColors: [Color] = [.red, .blue, .green, .yellow, .white]
    @StateObject var refreshManager = RefreshManager.shared
    @State private var needsRerender = false
    
    @EnvironmentObject var navigationState: NavigationState
    // State variables to manage current index, offset, and animation state
    @State private var currentIndex = 0
    @State private var offset: CGFloat = 0
    @State private var tappedArea: String = ""
    @State private var shouldScrollToBottom = false
    @State private var trackTapped = false
    @State private var visibleEllipses = 5 // Default number of visible ellipses
    
    @State private var cameBack = false
    
    @State private var rerender = false
    
    @State private var loaderContent: LoaderType?
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let safeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        let usableScreenHeight = screenHeight - safeAreaHeight
        let cardHeight:CGFloat = 180
        
        ZStack{
            
            if let loaderContent = loaderContent {
                CustomNavigationView(loaderType: loaderContent) {
                    self.loaderContent = nil
                }
            } else {
                
                ZStack {
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
                                ZStack{
                                    WrapperView(loader: .ring) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }
                                    .scaleEffect(0.5)
                                    .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                        
                                    }
                                ZStack{
                                    WrapperView(loader: .rings) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }
                                    .scaleEffect(0.4)
                                    .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                        
                                    }
                                
                            }.frame(width: screenWidth, height: cardHeight)
                            HStack(spacing: 20){
                                ZStack{
                                    WrapperView(loader: .space) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }
                                    .scaleEffect(0.52)
                                    .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                    }
                                ZStack{
                                    WrapperView(loader: .wheel) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }
                                    .scaleEffect(0.4)
                                    .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                        
                                    }
                            }.frame(width: screenWidth, height: cardHeight)
                            HStack(spacing: 20){
                                ZStack{
                                    WrapperView(loader: .track) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }
                                    .scaleEffect(0.52)
                                    .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                        
                                    }
                                ZStack{
                                    WrapperView(loader: .leaf) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }
                                    .scaleEffect(0.52)
                                    .frame(width: 300, height: 300)
                                    
                                }.frame(width: abs(screenWidth / 2 - 20), height: cardHeight)
                                    .overlay{
                                        RoundedRectangleStyle()
                                        
                                    }
                            }.frame(width: screenWidth, height: cardHeight)
                            
                            HStack{
                                ZStack{
                                    WrapperView(loader: .bar) { loaderContent  in
                                        self.loaderContent = loaderContent
                                    }.scaleEffect(1)
                                        .frame(width: 400, height: 80)
                                }.frame(width: screenWidth, height: cardHeight)
                                
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
                                                .foregroundStyle(Color(UIColor(hex: "1B90FF")))
                                                .padding(6)
                                            Link("Github", destination: URL(string: "https://www.github.com/realvjy")!)
                                                .foregroundStyle(Color(UIColor(hex: "1B90FF")))
                                                .font(.system(size: 15)).opacity(0.9)
                                        }
                                    }
                                }.frame(width: screenWidth, height: 400)
                            }.frame(width: abs(screenWidth - 20), height: 80)
                        } .background(Color("LaunchScreenBackgroundColor"))
                            .ignoresSafeArea()
                    }.frame(width: cardHeight)
                        
                    //cardHeight
                    
                }
            }
            
            
            // Home View Stack
            
            
            
        }
        
     
        
    }
    func printNavigationState() {
        print("Coming back from child: \(navigationState.isComingBackFromChild)")
    }
}



struct ContentView_Preview { // Example struct for holding the namespace
    @Namespace static var namespace
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
