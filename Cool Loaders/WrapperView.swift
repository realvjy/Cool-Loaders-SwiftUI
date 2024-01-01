//
//  WrapperView.swift
//  Cool Loaders
//
//  Created by vijay verma on 30/12/23.
//

import SwiftUI

struct WrapperView: View {

    let loader: LoaderType
    let onTap: (LoaderType) -> Void
    
    var body: some View {
            ZStack{
                Button(action: {
                    withAnimation{
                        onTap(loader)
                    }
                }){
                    Rectangle()
                        .fill(.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                ZStack{
                    loader.view.allowsHitTesting(false) // Disable interaction for loader view
                }
            }.ignoresSafeArea().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        
    }
}


enum LoaderType: String {
    case ring = "Ring"
    case rings = "Rings"
    case space = "Space"
    case wheel = "Wheel"
    case track = "Track"
    case leaf = "Leaf"
    case bar = "Bar"
    
    
    var view: AnyView {
        switch self {
        case .ring: return AnyView(Ring())
        case .rings: return AnyView(Rings())
        case .space: return AnyView(Space())
        case .wheel: return AnyView(Wheel())
        case .track: return AnyView(Track())
        case .leaf: return AnyView(Leaf())
        case .bar: return AnyView(Bar())
        }
    }
}


#Preview {
    WrapperView(loader: .wheel, onTap: { _ in })
        .preferredColorScheme(.dark)
}
