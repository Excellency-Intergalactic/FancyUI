//
//  File.swift
//  
//
//  Created by Luca on 28/01/2022.
//
#if os(iOS)
import Foundation
import SwiftUI
import WebKit

struct iOSWebView: UIViewRepresentable {
 
    var url: URL
    var showString: Bool
    var html: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        if showString {
            webView.loadHTMLString(html, baseURL: nil)
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
#endif
