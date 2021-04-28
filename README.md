# Vivace Music (iOS) 
![Vivace Music icon](Vivace/Assets.xcassets/AppIcon.appiconset/120-1.png)


Vivace is a music application that connects to your Apple Music iCloud Library and allows you to play from inside the app. 
Our big upcoming feature will be allowing transferring playlists between Apple Music and other music streaming services, like Spotify.

## Quick Start

First, open Xcode and clone this project. 
* Apple Music:
* Before this project will run, you'll need to add the dependencies. Go to File > Swift Packages > Add Package Dependency... and copy the dependencies from the Dependencies section of this README. 
* Next, you'll need to create the Localizable.strings file for your developer token. This assumes you have a developer account through Apple and have generated an Apple Music authorization-capable token. Go to File > New > File... and select Strings file. Name it Localizable.strings. In the file, type:
* "developerToken" = "insert token here";
* This app should now authenticate Apple Music users. As usual, do NOT share this file or token. It is added to the .gitignore, so it shouldn't upload on your clone.
* Spotify:
* Setting up the environment to use the Spotify framework and API can be done by following this link: https://developer.spotify.com/documentation/ios/quick-start/#configure-initial-music. This acts as a placeholder until a more comprehensive instruction set is made.

## Developer Requirements

* Active Apple Developer Program membership
* macOS 10.14.x or later
* iOS 13 or later
* Spotify Developer Account
* Active Apple Music subscription
* Xcode 12.x (developed using versions 12.4 and 12.5)

## User Requirements
* Apple Music is required to enable Apple Music-based features
* The Spotify App is required to enable Spotify playback. Free or premium accounts work!

## Dependencies
* https://github.com/SDWebImage/SDWebImageSwiftUI

## Known Issues

* Apple Music is **required** in order to currently use Now Playing and Search. App will hang and possibly crash.
* Music player repeats until stopped
* MiniPlayer stays above keyboard
* SearchView cannot scroll, possibly make it into table
* Not Playing status doesn't change until MiniPlayer is expanded and is not dynamic
* Keyboard does not dismiss unless "Return" is pressed
* App stops responding when results do not appear
* special characters crash application
* Spotify authorizes media change requests and token exchange, but the App Remote doesn't successfully switch media
* MiniPlayer doesn't update with Spotify, but the play/pause is functional
* STaRS version has exceptionally long boot time (probably due to the @State vars dependent on Spotify iOS SDK)

### Created by Jeremia Reyes, Devin Rogers, and Carlos Lopez
### This project was supervised by Dr. Cengiz Gunay at Georgia Gwinnett College
Apple Music and iCloud are registered trademarks of Apple Inc.

## License

* <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This source code is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
