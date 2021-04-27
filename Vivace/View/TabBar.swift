//
//  TabBar.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//

import SwiftUI
import StoreKit
import MediaPlayer
import SDWebImageSwiftUI

struct TabBar: View {
    @State var sessionManager = AppDelegate().sessionManager
    // if you change this to SceneDelegate(), it takes forever to initialize... hmm why
    // @State var appRemote = SceneDelegate().appRemote
    @State var expand = false
    @Namespace var animation
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @State private var currentSong = Song(id: "", name: "", artistName: "", artworkURL: "")
    @State var current = 2
    @State var playlistOne = "spotify:playlist:37i9dQZEVXbLRQDuF5jeBp"
    // @State var SPTImage image =
    @State var albumArtImageView: UIImageView!
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom),
               content: {
        
                TabView(selection: $current) {
//
                    MoreInfoCREATE()
                        .tag(0)
                        .tabItem {
                            Image(systemName: "tortoise.fill")
                            Text("Project Info")
                        }
//                    PlaylistsView()
//                        .tag(1)
//                        .tabItem {
//                            Image(systemName: "music.note.list")
//                            Text("Playlists")
//                        }
                    Search(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
                        .tag(2)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    SearchView(musicPlayer: self.$musicPlayer, currentSong: self.$currentSong)
                        .tag(3)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
//                    SettingsView()
//                        .tag(5)
//                        .tabItem {
//                            Image(systemName: "gearshape")
//                            Text("Settings")
//                        }
                    
                }
                // Let's decorate our TabView!
                .accentColor(.pink)
                // This lambda/EventListener/callback is triggered when the TabView is loaded.
                // practically speaking, anything in onAppear() will run when the app 'loads'.
                .onAppear() {
                    // APPLE MUSIC ACCESS:
                    // StoreKit (SK) request to access the user's media library
                    SKCloudServiceController.requestAuthorization { (status) in
                        // if the user authorizes access,
                        if status == .authorized {
                            // print the JSON payload
                            // TODO: actual lib things here
                            DispatchQueue.global(qos: .background).async {
                               print(AppleMusicAPI().fetchStorefrontID())
                                print(AppleMusicAPI().getUserPlaylists())
                            }
                            
                        }
                    }
                    // SPOTIFY ACCESS:
                    if #available(iOS 11, *) {
                          // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
                        
                          sessionManager.initiateSession(with: scopes, options: .clientOnly)
                        
                        }
                }
                MiniPlayer(animation: animation, expand: $expand, currentSong: self.$currentSong)

               })
    }
    
    
    
}
