//
//  BlurView.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(
            effect: UIBlurEffect(style:
            .systemChromeMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //
    }
}

