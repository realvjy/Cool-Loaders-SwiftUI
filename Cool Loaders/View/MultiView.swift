//
//  MultiView.swift
//  Cool Loaders
//
//  Created by vijay verma on 31/12/23.
//

import SwiftUI

struct MultiView: View {
    @State private var selectedContent: ContentType?
        
        var body: some View {
            VStack {
                if let selectedContent = selectedContent {
                    DetailView(contentType: selectedContent) {
                        self.selectedContent = nil
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(selectedContent.color.edgesIgnoringSafeArea(.all))
                    .offset(x: 20)
                    .onAppear(){
                        print("View detail visible")
                    }
                } else {
                    
                    HStack {
                        TappableView(content: .leaf) { selectedContent in
                            self.selectedContent = selectedContent
                        }
                        TappableView(content: .tree) { selectedContent in
                            self.selectedContent = selectedContent
                        }
                        TappableView(content: .rock) { selectedContent in
                            self.selectedContent = selectedContent
                        }
                        TappableView(content: .sand) { selectedContent in
                            self.selectedContent = selectedContent
                        }
                    }.onAppear(){
                        print("View visible")
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
}

#Preview {
    MultiView().preferredColorScheme(.dark)
}

struct IdentifiableContentType: Identifiable {
    let id = UUID()
    let contentType: ContentType
}

struct TappableView: View {
    let content: ContentType
    let onTap: (ContentType) -> Void
    
    var body: some View {
        ZStack {
            Button(action: {
                onTap(content)
            }) {
                Rectangle()
                    .fill(content.color.opacity(0.8))
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            content.view
                .foregroundColor(.white)
        }
    }
}


struct LeafView: View {
    var body: some View {
        Image(systemName: "leaf")
            .foregroundColor(.green)
    }
}

struct TreeView: View {
    var body: some View {
        Image(systemName: "tree")
            .foregroundColor(.brown)
    }
}

struct RockView: View {
    var body: some View {
        Image(systemName: "mountain")
            .foregroundColor(.gray)
    }
}

struct SandView: View {
    var body: some View {
        Image(systemName: "sun.haze")
            .foregroundColor(.yellow)
    }
}


struct DetailView: View {
    let contentType: ContentType
     let onDismiss: () -> Void
     
     var body: some View {
         ZStack {
             Button(action: {
                 onDismiss()
             }) {
                 contentType.view
                     .foregroundColor(.white)
                     .font(.title)
                     .padding()
                     .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                     .background(contentType.color.edgesIgnoringSafeArea(.all))
             }
         }
     }
}


enum ContentType: String {
    case leaf = "Leaf"
    case tree = "Tree"
    case rock = "Rock"
    case sand = "Sand"
    
    var color: Color {
        switch self {
        case .leaf: return .green
        case .tree: return .brown
        case .rock: return .gray
        case .sand: return .yellow
        }
    }
    
    var view: AnyView {
            switch self {
            case .leaf: return AnyView(LeafView())
            case .tree: return AnyView(TreeView())
            case .rock: return AnyView(RockView())
            case .sand: return AnyView(SandView())
            }
        }
}
