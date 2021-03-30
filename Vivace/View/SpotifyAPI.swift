//
//  SpotifyAPI.swift
//  Vivace
//
//  Created by Devin Rogers on 3/30/21.
//

import Foundation

let spotifyClientID = NSLocalizedString("spotifyClientID", comment: "")
let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

lazy var configuration = SPTConfiguration(
  clientID: SpotifyClientID,
  redirectURL: SpotifyRedirectURL
)

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
  let parameters = appRemote.authorizationParameters(from: url);

        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
        }
  return true
}

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url else {
        return
    }

    let parameters = appRemote.authorizationParameters(from: url);

    if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
        appRemote.connectionParameters.accessToken = access_token
        self.accessToken = access_token
    } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
        // Show the error
    }
}
