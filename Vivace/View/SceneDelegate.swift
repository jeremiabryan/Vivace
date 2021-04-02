import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate,
                     SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        //
    }
    

    static private let kAccessTokenKey = "access-token-key"
    private let redirectUri = URL(string:"vivace://redirect/")!
    private let clientIdentifier = NSLocalizedString("spotifyClientID", comment: "")
    
    
    var window: UIWindow?
    lazy var configuration = SPTConfiguration(
        clientID: clientIdentifier,
        redirectURL: redirectUri
    )
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
        
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
        
        if let access_token = parameters?["code"] {
          appRemote.connectionParameters.accessToken = access_token
            
        }
         else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(error_description)
        }

    }
    
    

    func sceneDidBecomeActive(_ scene: UIScene) {
        connect();
    }

    func sceneWillResignActive(_ scene: UIScene) {
            //Stop the never-ending loop!
            //"connecting" will cause us to call this very function when it changes over to Spotify, therefore we need a better way to decide when to disconnect
            //appRemote.disconnect()
        }

        func connect() {
            //attempt a connection
            
            appRemote.connect()
            
            //if it failed, aka we dont have a valid access token
            if (!appRemote.isConnected) {//ultimately access token issues aren't the only thing that will cause this the connection to fail
                
                //make spotify authorize and create an access token for us
                //self.appRemote.authorizeAndPlayURI("spotify:track:20I6sIOMTCkB6w7ryavxtO")
            }
        }

   
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        
        self.appRemote.playerAPI?.delegate = self
          self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
              debugPrint(error.localizedDescription)
            }
          })
    
    }
    
    

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("didFailConnectionAttemptWithError")
       
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("didDisconnectWithError")
        
    }
    
    var playerViewController: ViewController {
            get {
                let navController = self.window?.rootViewController?.children[0] as! UINavigationController
                return navController.topViewController as! ViewController
            }
        }
    
    
    
}
