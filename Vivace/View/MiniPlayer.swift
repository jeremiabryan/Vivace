//
//  MiniPlayer.swift
//  Vivace
//
//  Created by Devin Rogers on 2/9/21.
//

import SwiftUI

struct MiniPlayer: View {
    var animation: Namespace.ID
    @Binding var expand : Bool
    var body: some View {
        VStack {
            
            HStack(spacing: 15) {
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 55, height: 55)
                    .cornerRadius(15)
                Text("Lady Gaga")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: expand ? .infinity : 80)
        .background(
            VStack(spacing: 0) {
                BlurView()
                Divider()
            }
            .onTapGesture(perform: {
                    withAnimation(.spring()) {
                        expand.toggle()}
                    })
            )
        .offset(y: expand ? 0 : -48)
    }
}


