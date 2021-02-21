//
//  TabBar.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//

import SwiftUI

struct TabBar: View {
    
    @State var expand = false
    @Namespace var animation
    
    @State var current = 2
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom),
               content: {
        
                TabView(selection: $current) {
                    Playlists()
                        .tag(0)
                        .tabItem {
                            Image(systemName: "infinity")
                            Text("Playlists")
                        }
                    Text("Radio")
                        .tag(1)
                        .tabItem {
                            Image(systemName: "dot.radiowaves.left.and.right")
                            Text("Radio")
                        }
                    Search()
                        .tag(2)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    
                    Text("Current Source")
                        .tag(3)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Current Source")
                        }
                    
                }
                MiniPlayer(animation: animation, expand: $expand)
               })
        
    }
    
}
