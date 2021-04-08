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
    private let redirectUri = URL(string:"vivace://redirect/")!
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var currentSong: Song
    @State private var searchText = ""
    @State private var searchResults = [Song]()
    @State var playlistOne = "spotify:playlist:37i9dQZEVXbLRQDuF5jeBp"
    @State var playlistTwo = "spotify:playlist:137E6KBEACEjDWve3W6cgq"
    let stringScopes = [
                            "user-read-email", "user-read-private",
                            "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
                            "streaming", "app-remote-control",
                            "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
                            "user-library-modify", "user-library-read",
                            "user-top-read", "user-read-playback-position", "user-read-recently-played",
                            "user-follow-read", "user-follow-modify",
                        ]
    private let spotifyClientId = NSLocalizedString("spotifyClientID", comment: "")
    private let spotifyClientSecretKey = NSLocalizedString("spotifyClientSecret", comment: "")
    
    var scopes: SPTScope = [.userReadEmail, .userReadPrivate,
    .userReadPlaybackState, .userModifyPlaybackState,
    .userReadCurrentlyPlaying, .streaming, .appRemoteControl,
    .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
    .userLibraryModify, .userLibraryRead,
    .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
    .userFollowRead, .userFollowModify,]
    @State var search = ""
    var token = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing:20), count: 2)
    var codeVerifier: String = ""
        var responseTypeCode: String? {
            didSet {
                fetchSpotifyToken { (dictionary, error) in
                    if let error = error {
                        print("Fetching token request error \(error)")
                        return
                    }
                    let accessToken = dictionary!["access_token"] as! String
                    
                    DispatchQueue.main.async {
                        
                        SceneDelegate().appRemote.connectionParameters.accessToken = accessToken
                        SceneDelegate().appRemote.connect()

                    }
                }
            }
        }
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                HStack() {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    Spacer(minLength: 0)
                }
                
                VStack() {
                    HStack() {
                        Image("spotifylogo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                   height: 90,
                                   alignment: .center)
                            .cornerRadius(15)
                            .onAppear() {
                            }
                        Image("17570")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                   height: 90,
                                   alignment: .center)
                            .cornerRadius(15)
                            .onAppear() {
                            }
                    }
                    .background(Color.green)
                    .cornerRadius(15.0)
                    Text("Now Playing on Spotify")
                }
                .shadow(radius: 5)
                .onTapGesture {
                    var codeVerifier: String = ""
                        var responseTypeCode: String? {
                            didSet {
                                fetchSpotifyToken { (dictionary, error) in
                                    if let error = error {
                                        print("Fetching token request error \(error)")
                                        return
                                    }
                                    let accessToken = dictionary!["access_token"] as! String
                                    
                                    DispatchQueue.main.async {
                                        
                                        SceneDelegate().appRemote.connectionParameters.accessToken = accessToken
                                        
                                    }
                                    
                                }
                            }
                        }
                    AppDelegate().sessionManager.initiateSession(with: scopes, options: .clientOnly)
                    SceneDelegate().appRemote.authorizeAndPlayURI(playlistTwo)
                }
                LazyVGrid(columns: columns, spacing:20) {
                    VStack() {
                        ZStack(alignment: .bottomTrailing) {
                            Image("50numbr")
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                       height: 180,
                                       alignment: .center)
                                
                                .cornerRadius(15)
                                .shadow(color: .green, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                .onAppear() {
                                }
                            
                            
                            ZStack() {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.green)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                    .foregroundColor(.black)
                                    // .accentColor(.red)
                                    
                            }
                            .padding([.bottom, .trailing], 10)
                        }
                        Text("Vivace Top 50")
                    }
                    // .shadow(radius: 5)
                    
                    .onTapGesture {
                        
                        var codeVerifier: String = ""
                            var responseTypeCode: String? {
                                didSet {
                                    fetchSpotifyToken { (dictionary, error) in
                                        if let error = error {
                                            print("Fetching token request error \(error)")
                                            return
                                        }
                                        let accessToken = dictionary!["access_token"] as! String
                                        
                                        DispatchQueue.main.async {
                                            
                                            SceneDelegate().appRemote.connectionParameters.accessToken = accessToken
                                            
                                        }
                                        
                                    }
                                }
                            }
                        AppDelegate().sessionManager.initiateSession(with: scopes, options: .clientOnly)
                        SceneDelegate().appRemote.authorizeAndPlayURI(playlistTwo)
                    }
                    VStack() {
                        ZStack(alignment: .bottomTrailing) {
                            Image("chiptune")
                                
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                       height: 180,
                                       alignment: .center)
                                .cornerRadius(15)
                                .shadow(color: .green, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                .onAppear() {
                                }
                            
                            
                            
                            ZStack() {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.green)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                    .foregroundColor(.black)
                                    // .accentColor(.red)
                                    
                            }
                            .padding([.bottom, .trailing], 10)
                        }
                        Text("Vivace Chiptune")
                    }
                    // .shadow(radius: 5)
                    
                    .onTapGesture {
                        AppDelegate().playURI = playlistTwo
                        var codeVerifier: String = ""
                            var responseTypeCode: String? {
                                didSet {
                                    fetchSpotifyToken { (dictionary, error) in
                                        if let error = error {
                                            print("Fetching token request error \(error)")
                                            return
                                        }
                                        let accessToken = dictionary!["access_token"] as! String
                                        
                                        DispatchQueue.main.async {
                                            
                                            SceneDelegate().appRemote.connectionParameters.accessToken = accessToken
                                            SceneDelegate().appRemote.connect()
                                            SceneDelegate().appRemote.authorizeAndPlayURI(playlistTwo)
                                        }
                                        
                                    }
                                }
                            }
                        AppDelegate().sessionManager.initiateSession(with: scopes, options: .clientOnly)
                        SceneDelegate().appRemote.connect()
                        
                        // appRemote.authorizeAndPlayURI(playlistTwo)
                        SceneDelegate().appRemote.authorizeAndPlayURI(playlistTwo)
                          
                    }
                    
                    VStack() {
                        ZStack(alignment: .bottomTrailing) {
                            ZStack(alignment: .bottom) {
                                Image("albumblue")
                                    .resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                           height: 180,
                                           alignment: .center)
                                    
                                    .cornerRadius(15)
                                    .shadow(color: .red, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                    .onAppear() {
                                    }
//                                Capsule()
//                                    .fill(Color.red)
//                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 15)
                            }
                            
                            
                            ZStack() {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.red)
                                    .frame(width: 25, height: 25)
                                Image(systemName: "music.note")
                                    .foregroundColor(.white)
                                    // .accentColor(.red)
                                    
                            }
                            .padding([.bottom, .trailing], 10)
                            
                        }
                        
                        Text("Upbeat Mix")
                    }
                    .onTapGesture {
                        musicPlayer.stop()
                        // for some reason, some songs throw an error 6 (failed to prepare to play) here
                        // if that happens, try another song,
                        // but definitely TODO: notify user if that happens
                        musicPlayer.setQueue(with: ["475670122", "271978749",
                                                    "271978749", "724456984",
                                                    "1032913975"])
                        
                        musicPlayer.prepareToPlay()
                        musicPlayer.play()
                        
                    }
                    
                    ForEach(1...10, id: \.self) {index in
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                   height: 180,
                                   alignment: .center)
                            .cornerRadius(15)
                            .onAppear() {
                                
                                
                            }
                            
                            
                        
                    }
                }
                .padding(.top, 10)
            }
            .padding()
            .padding(.bottom, 80)
        }
        
    }
    
    
    
    func fetchSpotifyToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let spotifyAuthKey = "Basic \((spotifyClientId + ":" + spotifyClientSecretKey).data(using: .utf8)!.base64EncodedString())"
        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey, "Content-Type": "application/x-www-form-urlencoded"]
        do {
          var requestBodyComponents = URLComponents()
            let scopeAsString = stringScopes.joined(separator: " ") //put array to string separated by whitespace
          requestBodyComponents.queryItems = [URLQueryItem(name: "client_id", value: spotifyClientId), URLQueryItem(name: "grant_type", value: "authorization_code"), URLQueryItem(name: "code", value: responseTypeCode!), URLQueryItem(name: "redirect_uri", value: redirectUri.absoluteString), URLQueryItem(name: "code_verifier", value: codeVerifier), URLQueryItem(name: "scope", value: scopeAsString),]
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
extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
}
