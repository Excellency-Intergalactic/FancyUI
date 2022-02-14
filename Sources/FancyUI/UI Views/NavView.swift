//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 02/02/2022.
//

import SwiftUI

struct NavElement {
    var symbol: String
    var name: String
   // var view: some View
}

struct NavView: View {
    var views: [NavElement]
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSize
    #endif
    @ViewBuilder
    var body: some View {
        #if os(macOS)
        sidebar
        #else
        if horizontalSize == .compact {
            tabs
        } else {
            sidebar
        }
        #endif
    }
    
    var sidebar: some View {
        NavigationView {
            List {
                ForEach(views, id: \.symbol) { navElement in
                    NavigationLink {
                        
                    } label: {
                        Label(navElement.name, systemImage: navElement.symbol)
                    }
                }
            }.listStyle(SidebarListStyle())
        }
    }
    
    var tabs: some View {
        TabView {
            
        }
    }
    
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView(views: [])
    }
}
