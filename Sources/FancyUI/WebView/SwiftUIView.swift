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
    
    @ViewBuilder
    var body: some View {
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
        VStack {
            
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: "", url: "")
    }
}
