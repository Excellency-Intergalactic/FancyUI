//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 28/01/2022.
//

import SwiftUI

struct WebView: View {
    var html: String?
    var url: String?
    var sheet: Bool?
    @Environment(\.presentationMode) var presentationMode
    
    @ViewBuilder
    var body: some View {
        VStack {
            if sheet ?? false {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                }
            }.padding(.horizontal)
                    .padding(.bottom, 2)
                    .padding(.top, 10)
            }
        if html ?? "" == "" {
            #if os(iOS)
            iOSWebView(url: URL(string: url ?? "https://excellency.one") ?? URL(fileURLWithPath: ""), showString: false, html: "")
            #else
            MacWebView(url: URL(string: url ?? "https://excellency.one") ?? URL(fileURLWithPath: ""), showString: false, html: "")
            #endif
        } else {
            #if os(iOS)
            iOSWebView(url: URL(string: url ?? "https://excellency.one") ?? URL(fileURLWithPath: ""), showString: true, html: html ?? "")
            #else
            MacWebView(url: URL(string: url ?? "https://excellency.one") ?? URL(fileURLWithPath: ""), showString: true, html: html ?? "")
            #endif
        }
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: "", url: "https://apple.com", sheet: true)
    }
}
