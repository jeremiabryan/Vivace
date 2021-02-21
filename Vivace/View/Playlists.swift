//
//  Playlists.swift
//  Vivace
//
//  Created by Jeremia Reyes on 2/21/21.
//

import SwiftUI

struct Playlists: View {
    var body: some View {
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                UIApplication.shared.open(URL(string: "https://apple.com")!)
            }) {
                Text("Learn more")
                    .bold()
                Image(systemName: "chevron.right")
                    .font(.caption)
            }
        }
    }
}

struct Playlists_Previews: PreviewProvider {
    static var previews: some View {
        Playlists()
    }
}
