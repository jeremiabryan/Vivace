# Vivace Music (iOS) 
![Vivace Music icon](Vivace/Assets.xcassets/AppIcon.appiconset/120-1.png)


Vivace is a music application that connects to your Apple Music iCloud Library and allows you to play from inside the app. 
Our big upcoming feature will be allowing transferring playlists between Apple Music and other music streaming services, like Spotify.

## Quick Start

First, open Xcode and clone this project. 
Apple Music:
* Before this project will run, you'll need to add the dependencies. Go to File > Swift Packages > Add Package Dependency... and copy the dependencies from the Dependencies section of this README. 
* Next, you'll need to create the Localizable.strings file for your developer token. This assumes you have a developer account through Apple and have generated an Apple Music authorization-capable token. Go to File > New > File... and select Strings file. Name it Localizable.strings. In the file, type:
* "developerToken" = "insert token here";
* This app should now authenticate Apple Music users. As usual, do NOT share this file or token. It is added to the .gitignore, so it shouldn't upload on your clone.
Spotify:
* Setting up the environment to use the Spotify framework and API can be done by following this link: https://developer.spotify.com/documentation/ios/quick-start/#configure-initial-music. This acts as a placeholder until a more comprehensive instruction set is made.

## Requirements

* Active Apple Developer Program membership
* macOS 10.14.x or later
* iOS 13 or later
* Active Apple Music subscription
* Xcode 12.x (developed using versions 12.4 and 12.5)

## Dependencies
* https://github.com/SDWebImage/SDWebImageSwiftUI

## Known Issues

* Music player repeats until stopped
* MiniPlayer stays above keyboard
* SearchView cannot scroll, possibly make it into table
* Not Playing status doesn't change until MiniPlayer is expanded and is not dynamic
* Keyboard does not dismiss unless "Return" is pressed
* App stops responding when results do not appear
* special characters crash application


### Created by Jeremia Reyes, Devin Rogers, and Carlos Lopez

Apple Music and iCloud are registered trademarks of Apple Inc.
