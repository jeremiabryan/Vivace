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
    @State private var searchText = ""
    @State private var searchResults = [Song]()
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
    @Binding var musicPlayer: MPMusicPlayerController
    @Binding var currentSong: Song
    var scopes: SPTScope = [.userReadEmail, .userReadPrivate,
    .userReadPlaybackState, .userModifyPlaybackState,
    .userReadCurrentlyPlaying, .streaming, .appRemoteControl,
    .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
    .userLibraryModify, .userLibraryRead,
    .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
    .userFollowRead, .userFollowModify,]
    @State var sessionManager = AppDelegate().sessionManager
    @State var search = ""
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
                        SceneDelegate().appRemote.authorizeAndPlayURI("spotify:track:20I6sIOMTCkB6w7ryavxtO")
                        SceneDelegate().appRemote.connect()
                        
                    }
                }
            }
        }
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                HStack() {
                    Text("Search")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    Spacer(minLength: 0)
                    
                }
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    TextField("Search", text:$search)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(15)
                
                
                List {
                                ForEach(searchResults, id:\.id) { song in
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            Text(song.name)
                                                .font(.headline)
                                            Text(song.artistName)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Button(action: {
                                            self.currentSong = song
                                            self.musicPlayer.setQueue(with: [song.id])
                                            self.musicPlayer.play()
                                        }) {
                                            Image(systemName: "play.fill")
                                                .foregroundColor(.pink)
                                        }
                                    }
                                }
                            }
                            .accentColor(.pink)
                        
                
                LazyVGrid(columns: columns, spacing:20) {
                    ForEach(1...10, id: \.self) {index in
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 2,
                                   height: 180,
                                   alignment: .center)
                            .cornerRadius(15)
                            .onAppear() {
                                
                                if #available(iOS 11, *) {
                                      // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
                                      sessionManager.initiateSession(with: scopes, options: .clientOnly)
                                    
                                    }
                            }
                            .onTapGesture {
                                AppDelegate().appRemote.authorizeAndPlayURI("spotify:track:20I6sIOMTCkB6w7ryavxtO")
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
