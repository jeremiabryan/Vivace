//
//  SourceView.swift
//  Vivace
//
//  Created by Carlos Lopez on 5/10/21.
//

import SwiftUI

struct SourceView: View {
    var body: some View {
        NavigationView{
            
            VStack{
                
                HStack{
                    NavigationLink(destination: Webview(url: "https://accounts.spotify.com/en/login/"), label: {
                        Image("NewSpotifyRectangle")
                            
                    })
                    NavigationLink(destination: Webview(url: "https://www.apple.com"), label: {
                        Image("appleMusicRectangle")
                            
                    })
                }
            }
            .navigationTitle("Select Source")
        }
    }
}

struct SpotifyView: View{
    var body: some View{
        NavigationView{
            VStack{
                NavigationLink(destination: Webview(url: "https://accounts.spotify.com/en/login/"), label: {
                    Image("NewSpotifyRectangle")
                        .navigationBarTitle("Spotify Login")
                }
                )}
        }
    }
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView()
    }
}
