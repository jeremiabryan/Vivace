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

struct MiniPlayer: View {
    var height = UIScreen.main.bounds.height / 3
    var animation: Namespace.ID
    @Binding var expand : Bool
    @State var volume : CGFloat = 0
    @State var offset : CGFloat = 0
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
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
                
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: expand ? height : 55, height: expand ? height: 55)
                    .cornerRadius(15)
                if (!expand) {
                    Text("Now Playing")
                        .font(.title2)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                if (!expand) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(syste      çmName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                }
            }
            .padding(.horizontal)
            
            VStack(spacing: 15) {
                Spacer(minLength: 0)
                
                HStack {
                    if (expand) {
                        Text("Lady Gaga")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    Spacer(minLength: 0)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                    
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
                
                Button(action: {}) {
                    Image(systemName: "stop.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    
                }
                .padding()
                
                Spacer(minLength: 0)
                
                HStack(spacing: 15) {
                    Image(systemName: "speaker.fill")
                    Slider(value: $volume)
                    Image(systemName: "speaker.wave.2.fill")
                }
                .padding()
                HStack(spacing: 22) {
                    Button(action: {}) {
                        Image(systemName: "arrow.up.message")
                    
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Button(action: {}) {
                        Image(systemName: "airplayaudio")
                    
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Button(action: {}) {
                        Image(systemName: "list.bullet")
                    
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
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
}


