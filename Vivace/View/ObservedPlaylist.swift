//
//  ObservedPlaylist.swift
//  Vivace
//
//  Created by Devin Rogers on 4/21/21.
//

import Foundation

class ObservedPlaylist: ObservableObject {
    @Published var playlists: [Playlist]
    
    init(playlists: [Playlist]) {
        self.playlists = playlists
    }
    
    func addPlaylists(playlists: [Playlist]) {
        self.playlists = playlists
    }
    
    func getPlaylists() -> [Playlist] {
        return self.playlists
    }
   
}
