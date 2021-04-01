import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate,
SPTAppRemoteDelegate {

    static private let kAccessTokenKey = "access-token-key"
    private let redirectUri = URL(string:"spotify-ios-quick-start://spotify-login-callback")!
    private let clientIdentifier = NSLocalizedString("spotifyClientID", comment: "")
    
    var window: UIWindow?

    lazy var appRemote: SPTAppRemote = {
        let configuration = SPTConfiguration(clientID: self.clientIdentifier, redirectURL: self.redirectUri)
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        configuration.playURI = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
        return appRemote
    }()

    var accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(accessToken, forKey: SceneDelegate.kAccessTokenKey)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        let parameters = appRemote.authorizationParameters(from: url);

        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = access_token
            self.accessToken = access_token
        } else if let _ = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
        }

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        connect();
    }

    func sceneWillResignActive(_ scene: UIScene) {
        appRemote.disconnect()
    }

    func connect() {
        appRemote.connect()
        
    }

   
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
    
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("didFailConnectionAttemptWithError")
       
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("didDisconnectWithError")
        
    }

  
}
