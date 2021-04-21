//
//  Playlist.swift
//  Vivace
//
//  Created by Devin Rogers on 4/20/21.
//

import Foundation

class Playlist: ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var canEdit: Bool
    
    init(id: String, name: String, canEdit: Bool) {
        self.id = id
        self.name = name
        self.canEdit = canEdit
    }
}
