//
//  SourceView.swift
//  Vivace
//
//  Created by Carlos Lopez on 5/10/21.
//

import SwiftUI

struct SourceView: View {

    let script = AppleMusicAPI()
    let newScript = SceneDelegate()
    
    func appleMusicAuth() -> String {
        let myString = "Apple Music is Connected"
        let noString = "Not Connected"
        if script.isAuthenticated() == true{
            return myString
        } else{
            return noString
        }
    }
    
    func spotifyAuth() -> String{
        let success = "Spotify is Connected"
        let fail = "Not Connected"
        if newScript.isAuthenticated() == true{
            return success
        } else{
            return fail
        }
    }
    
    
    var body: some View {
        NavigationView{
            
            VStack{
                Text(spotifyAuth())
                    .offset(x:-100, y: 300)
                    .font(.title)
                Text(appleMusicAuth())
                    .offset(x:100, y: 300)
                    .font(.title)
                HStack{
                    NavigationLink(destination: Webview(url: "https://accounts.spotify.com/authorize?"), label: {
                        Image("NewSpotifyRectangle")
                            .offset(y: -50)
                            
                    })
                    NavigationLink(destination: Webview(url: "https://music.apple.com/login"), label: {
                        Image("appleMusicRectangle")
                            .offset(y: -50)
                            
                    })
                }
                
            }
            .navigationTitle("Select Source")
        }
    }
}


struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView()
    }
}
