//
//  TabBar.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct TabBar: View {
    
    @State var expand = false
    @Namespace var animation
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @State private var currentSong = Song(id: "", name: "", artistName: "", artworkURL: "")
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
                    PlaylistsView()
                        .tag(1)
                        .tabItem {
                            Image(systemName: "music.note.list")
                            Text("Playlists")
                        }
                    Search(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
                        .tag(2)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    /*
                    Text("Current Source")
                        .tag(3)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Current Source")
                        }
 */
                    SearchView(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
                        .tag(4)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    SettingsView()
                        .tag(5)
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                    
                }
                // Let's decorate our TabView!
                .accentColor(.pink)
                // This lambda/EventListener/callback is triggered when the TabView is loaded.
                // practically speaking, anything in here will run when the app 'loads'.
                .onAppear() {
                    // StoreKit (SK) request to access the user's media library
                    SKCloudServiceController.requestAuthorization { (status) in
                        // if the user authorizes access,
                        if status == .authorized {
                            // print the JSON payload
                            // TODO: actual lib things here
                            DispatchQueue.global(qos: .background).async {
                               print(AppleMusicAPI().fetchStorefrontID())
                                print(AppleMusicAPI().searchAppleMusic("Taylor Swift"))
                                
                            }
            
                        }
                    }
                }
                MiniPlayer(animation: animation, expand: $expand)

               })
            }
    
}
