//
//  TabBar.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//

import SwiftUI

struct TabBar: View {
    
    @State var current = 2
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom),
               content: {
        
                TabView(selection: $current) {
                    Text("Library")
                        .tag(0)
                        .tabItem {
                            Image(systemName: "rectangle.stack.fill")
                            Text("Library")
                        }
                    Text("Radio")
                        .tag(1)
                        .tabItem {
                            Image(systemName: "dot.radiowaves.left.and.right")
                            Text("Radio")
                        }
                    Text("Search")
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
                MiniPlayer()
               })
        
    }
    
}
