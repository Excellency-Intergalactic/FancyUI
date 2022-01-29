//
//  File.swift
//  
//
//  Created by Luca on 28/01/2022.
//

#if os(macOS)
import Foundation
import SwiftUI
import WebKit

struct MacWebView: NSViewRepresentable {
 
    var url: URL
    var showString: Bool
    var html: String
    
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateNSView(_ webView: WKWebView, context: Context) {
        if showString {
            webView.loadHTMLString(html, baseURL: nil)
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
#endif
