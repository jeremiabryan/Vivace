//
//  SearchView.swift
//  Vivace
//
//  Created by Devin Rogers on 3/10/21.
//

import SwiftUI
import StoreKit
import MediaPlayer


struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults = [Song]()
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var currentSong: Song
    
    var body: some View {
        VStack {
            TextField("Search Songs", text: $searchText, onCommit: {
                UIApplication.shared.resignFirstResponder()
                if self.searchText.isEmpty {
                    self.searchResults = []
                } else {
                    SKCloudServiceController.requestAuthorization { (status) in
                        if status == .authorized {
                            // does not freeze and crash because thredz
                            DispatchQueue.global(qos: .background).async {
                                self.searchResults = AppleMusicAPI().searchAppleMusic(self.searchText)
                            }
                            
                        }
                    }
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
            .accentColor(.pink)
            
            List {
                ForEach(searchResults, id:\.id) { song in
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text(song.name)
                                .font(.headline)
                            Text(song.artistName)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                            self.currentSong = song
                            MiniPlayer.songName = song.name
                            self.musicPlayer.setQueue(with: [song.id])
                            self.musicPlayer.play()
                        }) {
                            Image(systemName: "play.fill")
                                .foregroundColor(.pink)
                        }
                    }
                }
            }
            .accentColor(.pink)
        }
    }
}
