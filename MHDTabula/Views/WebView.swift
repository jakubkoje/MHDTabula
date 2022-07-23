//
//  WebView.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 23/07/2022.
//

import Foundation
import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
