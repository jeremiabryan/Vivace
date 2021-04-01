//
//  Search.swift
//  Vivace
//
//  Created by Devin Rogers on 2/11/21.
//

import SwiftUI
import StoreKit
import MediaPlayer


struct Search: View {
    @State private var searchText = ""
    @State private var searchResults = [Song]()
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var currentSong: Song
    
    @State var search = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing:20), count: 2)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                HStack() {
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    Spacer(minLength: 0)
                    
                }
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    TextField("Search", text:$search)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(15)
                
                
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
                        
                
                LazyVGrid(columns: columns, spacing:20) {
                    ForEach(1...10, id: \.self) {index in
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                   height: 180,
                                   alignment: .center)
                            .cornerRadius(15)
                            .onTapGesture {
                                SceneDelegate().connect()
                            }
                            
                     
                    }
                }
                .padding(.top, 10)
            }
            .padding()
            .padding(.bottom, 80)
        }
        
    }
}


