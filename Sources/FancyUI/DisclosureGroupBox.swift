//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 17/01/2022.
//

import SwiftUI

struct DisclosureGroupBox<Label, Content> : View where Label : View, Content : View {
    var symbolChoice: expandSymbol?
    var multicolorSymbol: Bool?
    var showDivider: Bool?
    
    @State var showingDetail: Bool = false
    @ViewBuilder var content: () -> Content
    @ViewBuilder var label: () -> Label
    
        
    var body: some View {
        if #available(iOS 14.0, *) {
            GroupBox {
                if showingDetail {
                    content()
                }
            } label: {
                HStack {
                    label()
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
                                .font(.body)
                                .foregroundColor(.accentColor)
                                .imageScale(.large)
                                .rotationEffect(.degrees(showingDetail ? 90 : 0))
                                .scaleEffect(showingDetail ? 1.25 : 1)
                        }
                    }.buttonStyle(PlainButtonStyle())
                }.onTapGesture {
                    withAnimation {
                        showingDetail.toggle()
                    }
                }
            }
        }
    }
}

struct DisclosureGroupBox_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupBox {
            Text(verbatim: "Hello, world")
        } label: {
            Text("Hello")
        }
    }
}
