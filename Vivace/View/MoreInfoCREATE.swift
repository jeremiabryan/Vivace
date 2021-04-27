//
//  MoreInfoCREATE.swift
//  Vivace
//
//  Created by Jeremia Reyes on 4/27/21.
//

import SwiftUI

struct MoreInfoCREATE: View {
    var body: some View {
        VStack {
        Link("Check out our Project's GitHub Page!", destination: URL(string: "https://github.com/jeremiabryan/Vivace")!)
            
        Text("\n\n\nWe'd greatly appreciate it if you shared our project with your friends and family! \n\nWe want to improve this project way past our class and make this into a fully functioning app and we'd love your help.")
            
            Link("\n\n\n Tap to visit our testing link to share", destination: URL(string: "https://testflight.apple.com/join/shJ64we4")!)
            
        }
        
    }
    
}


