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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        
     
    }
}

struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView()
    }
}
