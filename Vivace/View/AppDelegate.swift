//
//  AppDelegate.swift
//  iOS SDK Quick Start
//
//  Created by Spotify on 14/06/2018.
//  Copyright © 2018 Spotify for Developers. All rights reserved.
//
import UIKit

// @UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    // codeverifier is not required because we are using the iOS SDK, so we use an empty string to appease the HttpRequest gods.
    var codeVerifier: String = ""
    var playURI = ""
    var window: UIWindow?
    var responseTypeCode: String? {
        didSet {
          fetchSpotifyToken { (dictionary, error) in
            if let error = error {
              print("Fetching token request error \(error)")
              return
            }
            let accessToken = dictionary!["access_token"] as! String
            DispatchQueue.main.async {
              self.appRemote.connectionParameters.accessToken = accessToken
              self.appRemote.connect()
            }
          }
        }
      }
    let SpotifyClientID = NSLocalizedString("spotifyClientID", comment: "")
    let SpotifyClientSecret = NSLocalizedString("spotifyClientSecret", comment: "")
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    let redirectUri = URL(string:"previewtify://")!
    //remove scopes you don't need
    let stringScopes = ["user-read-email", "user-read-private",
    "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
    "streaming", "app-remote-control",
    "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
    "user-library-modify", "user-library-read",
    "user-top-read", "user-read-playback-position", "user-read-recently-played",
    "user-follow-read", "user-follow-modify",]
    lazy var configuration = SPTConfiguration(
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://[your token swap app domain here]/api/token"),
           let tokenRefreshURL = URL(string: "https://[your token swap app domain here]/api/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()

    lazy var appRemote: SPTAppRemote = {
        
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)

        return true
    }
    
    internal func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        
        return true
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        self.appRemote.connectionParameters.accessToken = session.accessToken
        self.appRemote.connect()
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print(session)
    }
    
    func connect() {
        print("connect()")
        self.playURI = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
        
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
        self.playURI = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
        
       // Want to play a new track?
        self.appRemote.playerAPI?.play("spotify:track:13WO20hoD72L0J13WTQWlT", callback: { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }

    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
        print("isPaused", playerState.isPaused)
        print("track.uri", playerState.track.uri)
        print("track.name", playerState.track.name)
        print("track.imageIdentifier", playerState.track.imageIdentifier)
        print("track.artist.name", playerState.track.artist.name)
        print("track.album.name", playerState.track.album.name)
        print("track.isSaved", playerState.track.isSaved)
        print("playbackSpeed", playerState.playbackSpeed)
        print("playbackOptions.isShuffling", playerState.playbackOptions.isShuffling)
        print("playbackOptions.repeatMode", playerState.playbackOptions.repeatMode.hashValue)
        print("playbackPosition", playerState.playbackPosition)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        if self.appRemote.isConnected {
            self.appRemote.disconnect()
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if let _ = self.appRemote.connectionParameters.accessToken {
            self.appRemote.connect()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func fetchSpotifyToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
      let url = URL(string: "https://accounts.spotify.com/api/token")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      let spotifyAuthKey = "Basic \((SpotifyClientID + ":" + SpotifyClientSecret).data(using: .utf8)!.base64EncodedString())"
      request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey, "Content-Type": "application/x-www-form-urlencoded"]
      do {
        var requestBodyComponents = URLComponents()
        let scopeAsString = stringScopes.joined(separator: " ") //put array to string separated by whitespace
        
        requestBodyComponents.queryItems = [URLQueryItem(name: "client_id", value: SpotifyClientID), URLQueryItem(name: "grant_type", value: "authorization_code"), URLQueryItem(name: "code", value: responseTypeCode!), URLQueryItem(name: "redirect_uri", value: redirectUri.absoluteString), URLQueryItem(name: "code_verifier", value: codeVerifier), URLQueryItem(name: "scope", value: scopeAsString),]
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data,                            // is there data
          let response = response as? HTTPURLResponse,  // is there HTTP response
          (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
          error == nil else {                           // was there no error, otherwise ...
            print("Error fetching token \(error?.localizedDescription ?? "")")
            return completion(nil, error)
          }
          let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
          print("Access Token Dictionary=", responseObject ?? "")
          completion(responseObject, nil)
        }
        task.resume()
      } catch {
        print("Error JSON serialization \(error.localizedDescription)")
      }
    }
  
  
}
