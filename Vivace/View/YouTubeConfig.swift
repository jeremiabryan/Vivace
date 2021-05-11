//
//  YouTubeConfig.swift
//  Vivace
//
//  Created by Carlos Lopez on 5/11/21.
//

import Foundation

public struct Config {

    public init(clientId: String,
                redirectUri: String) {
        self.clientId = "116550118079-n2uiv49s6fbf376u7hpdvufvr3aacl8c.apps.googleusercontent.com"
        self.redirectUri = "com.googleusercontent.apps.116550118079-n2uiv49s6fbf376u7hpdvufvr3aacl8c://"
    }

    public var clientId: String
    public var redirectUri: String

}
