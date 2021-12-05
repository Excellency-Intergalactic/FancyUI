//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 05.12.21.
//

import SwiftUI

struct FancyDisclosure<Content: View>: View {
    var title: String?
    var symbolChoice: expandSymbol?
    var multicolorSymbol: Bool?
    @State var showingDetail: Bool = false
    @ViewBuilder var content: Content
    
        
    var body: some View {
        VStack {
            HStack {
                Text(title ?? "")
                    .font(.system(.headline, design: .rounded))
                Spacer()
                Button(action: {
                    withAnimation {
                        showingDetail.toggle()
                    }
                }) {
                    if multicolorSymbol ?? false {
                        Image(systemName: (symbolChoice ?? .chevronCircle).rawValue)
                            .renderingMode(.original)
                            .imageScale(.large)
                            .rotationEffect(.degrees(showingDetail ? 90 : 0))
                            .scaleEffect(showingDetail ? 1.25 : 1)
                            .padding(.trailing, 5)
                    } else {
                        Image(systemName: (symbolChoice ?? .chevronCircle).rawValue)
                            .foregroundColor(.accentColor)
                            .imageScale(.large)
                            .rotationEffect(.degrees(showingDetail ? 90 : 0))
                            .scaleEffect(showingDetail ? 1.25 : 1)
                            .padding(.trailing, 5)
                    }
                }.buttonStyle(PlainButtonStyle())
            }.onTapGesture {
                withAnimation {
                    showingDetail.toggle()
                }
            }
            
            if showingDetail {
                content
                    .padding(.vertical, 5)
            }
        }
    }
}

struct FancyDisclosure_Previews: PreviewProvider {
    static var previews: some View {
        FancyDisclosure(title: "Hello") {
            Text(verbatim: "Hello, world")
        }
    }
}
