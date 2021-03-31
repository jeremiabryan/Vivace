////
////  SpotifyAPI.swift
////  Vivace
////
////  Created by Devin Rogers on 3/30/21.
////
//
//import Foundation
//
//let spotifyClientID = NSLocalizedString("spotifyClientID", comment: "")
//let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
//// make this lazy if not already global:
//var configuration = SPTConfiguration(
//  clientID: spotifyClientID,
//  redirectURL: SpotifyRedirectURL
//)
//
//func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//  let parameters = appRemote.authorizationParameters(from: url);
//
//        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//            appRemote.connectionParameters.accessToken = access_token
//            self.accessToken = access_token
//        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            // Show the error
//        }
//  return true
//}
//
//func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//    guard let url = URLContexts.first?.url else {
//        return
//    }
//
//    let parameters = appRemote.authorizationParameters(from: url);
//
//    if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//        appRemote.connectionParameters.accessToken = access_token
//        self.accessToken = access_token
//    } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//        // Show the error
//    }
//}
class SpotifyAPI {
    ///fetch Spotify access token. Use after getting responseTypeCode
    
}
