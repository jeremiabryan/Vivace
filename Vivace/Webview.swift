//
//  Webview.swift
//  Vivace
//
//  Created by Carlos Lopez on 5/10/21.
//

import Foundation
import SwiftUI
import WebKit

struct Webview: UIViewRepresentable{
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else{
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebview = WKWebView()
        wkWebview.load(request)
        return wkWebview
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Webview>) {
        
    }
}
