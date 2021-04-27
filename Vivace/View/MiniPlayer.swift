//
//  MiniPlayer.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//
// NOTE: The addition of the arrow.up.message, airplayaudio, and list.bullet buttons
// make this app graphically ineligible for smaller screen devices.
// Smaller devices may need a different build if this can't be fixed (by the project deadline).
// For testing, we should probably fix it.
// Worst case scenario, compress the GUI for all device builds.

import SwiftUI
import MediaPlayer
import CoreGraphics
import SDWebImageSwiftUI

let volumeView = MPVolumeView()

struct MiniPlayer: View {
    @State var playerPaused = true
    
    var height = UIScreen.main.bounds.height / 3
    var animation: Namespace.ID
    // @State means it can be passed on to other views!
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @Binding var expand : Bool
    @State var volume : CGFloat = 0
    @State var offset : CGFloat = 0
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    @State static var songName = "---"
    @Binding var currentSong: Song
    
    
    
    var body: some View {
        
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top,expand ? safeArea?.top : 0)
                .padding(.vertical, expand ? 30 : 0)
            
            HStack(spacing: 15) {
                if expand {
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                }
                
                WebImage(url:
                            // it was .playbackState == .playing ?;
                            // use that if we encounter issues with nowPlayingItem != nil, but
                            // this should allow you to maintain album art when paused
                            (MPMusicPlayerController.applicationMusicPlayer.nowPlayingItem != nil) ?
                            URL(string:
                                    self.currentSong.artworkURL
                                    .replacingOccurrences(of: "{w}",
                                                          with: "\(600)")
                                    .replacingOccurrences(of: "{h}",
                                                          with: "\(600)"))
                            : URL(string: "https://i.imgur.com/5def0zoh.jpg")
                )
                                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height: 55, height: expand ? height: 55)
                    .cornerRadius(expand ? 10 : 90)
                                    .shadow(radius: 10)
                                
                
                                
                if (!expand) {
                    Text(self.musicPlayer.nowPlayingItem?.title ?? "Not Playing")
                        .font(.title3)
                        //.fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                if (!expand) {
                    
// Mini Player music actions: backward skip, play/pause, and forward skip
                    Button(action: {
                          self.playerPaused.toggle()
                          if self.playerPaused {
                            self.musicPlayer.pause()
                          }
                          else {
                            self.musicPlayer.play()
                          }
                        }) {
                          Image(systemName: playerPaused ? "play.fill" : "pause.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.primary)
                        }

                    Button(action: self.musicPlayer.skipToNextItem, label: {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.primary)
                    })
                }
            }
            .padding(.horizontal)
            
            VStack (spacing: 15) {
                Spacer (minLength: 0)
                
                HStack {
                    if (expand) {
                        VStack(alignment: .leading) {
                        Text(self.musicPlayer.nowPlayingItem?.title ?? "Not Playing")
                            .font(.title)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label", in: animation)
                            
                        Text(self.musicPlayer.nowPlayingItem?.artist ?? "Not Playing")
                            .font(.title3)
                            .foregroundColor(.primary)
                            //.fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label1", in: animation)
                           .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    }
                    }
                    Spacer(minLength: 0)
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        Image(systemName: "ellipsis.circle")
//                            .font(.title2)
//                            .foregroundColor(.primary)
//                    })
                    
                }
                .padding(.top, 20)
                .padding()
                
                // Live String
                HStack {
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7), Color.primary.opacity(0.1)]), startPoint: .leading, endPoint: .trailing))
                        .frame(height: 4)
                    Text("LIVE")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.1), Color.primary.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
                        .frame(height: 4)
                    
                }
                .padding()
              
                HStack(spacing: 75) {
                // regular music Player music actions: backward skip, play/pause, and forward skip
                Button(action: self.musicPlayer.skipToPreviousItem, label: {
                    Image(systemName: "backward.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 42))
                })
                .onTapGesture {
                    if self.musicPlayer.currentPlaybackTime < 5 {
                        self.musicPlayer.skipToPreviousItem()
                    } else {
                        self.musicPlayer.skipToBeginning()
                    }
                }
                    
                Button(action: {
                      self.playerPaused.toggle()
                      if self.playerPaused {
                        self.musicPlayer.pause()
                      }
                      else {
                        self.musicPlayer.play()
                      }
                    }) {
                      Image(systemName: playerPaused ? "play.fill" : "pause.fill")
                        .font(.system(size: 42))
                        .foregroundColor(.primary)
                    }

                Button(action: self.musicPlayer.skipToNextItem, label: {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 42))
                        .foregroundColor(.primary)
                })
                .onTapGesture {
                    self.musicPlayer.skipToNextItem()
                }
                }
                .padding()
                
                Spacer(minLength: 0)
               
                HStack(spacing: 0) {
//                    Image(systemName: "speaker.fill")
//                        .font(.system(size: 16))
                        
                    VolumeSlider()
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                    
//                    Image(systemName: "speaker.wave.2.fill")
//                        .font(.system(size: 16))
                    
                }
                .padding()
//                HStack(spacing: 25) {
//                    Button(action: {}) {
//                        Image(systemName: "arrow.up.message")
//
//                            .font(.title2)
//                            .foregroundColor(.primary)
//                    }
//                    Button(action: {}) {
//                        Image(systemName: "airplayaudio")
//
//                            .font(.title2)
//                            .foregroundColor(.primary)
//                    }
//                    Button(action: {}) {
//                        Image(systemName: "list.bullet")
//
//                            .font(.title2)
//                            .foregroundColor(.primary)
//                    }
//
//
//                }
//                .padding(.bottom, safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
            }
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity : 80)
        .background(
            VStack(spacing: 0) {
                BlurView()
                Divider()
            }
            .onTapGesture(perform: {
                withAnimation(.spring()){expand = true}
                    })
            )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
        .ignoresSafeArea()
    }
    
    // restricts to when expanded
    func onChanged(value: DragGesture.Value) {
        if (value.translation.height > 0 && expand) {
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)) {
            if value.translation.height > height {
                expand = false
            }
            offset = 0
        }
    }
    
    func setCurrentSong(song:Song) {
        self.currentSong = song
    }
    
    
    func setTitle(value:String) {
        MiniPlayer.songName = value
    }
    
}
