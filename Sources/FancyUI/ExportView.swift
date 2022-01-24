//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 24/01/2022.
//

import SwiftUI

struct LargeFeatureView: View {
    var systemImage: String
    var title: String
    var text: String?
    var multicolourSymbol: Bool?
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .renderingMode(multicolourSymbol ?? true ? .original : .template)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
                .foregroundColor(.black)
                .shadow(radius: 10)
            
            Button(action: action) {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.callout)
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding()
            }.buttonStyle(PlainButtonStyle())
            Text(text ?? "")
                .font(.subheadline)
            
        }.padding()
        .frame(width: 400, height: 400)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.7, blue: 0.7), Color(red: 0.7, green: 0.7, blue: 1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10)
        .padding(50)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LargeFeatureView(systemImage: "bonjour", title: "Hello", text: "Press to export", action: {})
    }
}
