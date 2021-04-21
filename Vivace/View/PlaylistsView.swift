//
//  PlaylistsView.swift
//  Vivace
//
//  Created by Jeremia Reyes on 3/18/21.
//

import SwiftUI

var scopes: SPTScope = [.userReadEmail, .userReadPrivate,
.userReadPlaybackState, .userModifyPlaybackState,
.userReadCurrentlyPlaying, .streaming, .appRemoteControl,
.playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
.userLibraryModify, .userLibraryRead,
.userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
.userFollowRead, .userFollowModify,]

struct PlaylistsView: View {
    @State var msg: String = ""
    @ObservedObject var observedPlaylist = ObservedPlaylist(playlists: [Playlist]())
      var body: some View {
        List {
            Button("Press me") {
                
            }
            .onTapGesture {
            }
            ForEach(observedPlaylist.getPlaylists(), id:\.id) { playlist in
                HStack {
                    
                        
                    VStack(alignment: .leading) {
                        Text(playlist.name)
                            .font(.headline)
                        Text(playlist.id)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .environmentObject(observedPlaylist)
            }
        }
      }
    

}


struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView()
    }
}
