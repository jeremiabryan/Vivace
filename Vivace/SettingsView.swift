//
//  SettingsView.swift
//  Vivace
//
//  Created by Carlos Lopez on 3/18/21.
//

import SwiftUI

struct SettingsView : View {
    var body: some View{
        ScrollView {
            VStack(spacing: 20) {
                HStack() {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                }
                Button(action: {
                    print("Account tapped!")
                }) {
                    HStack {
                        Image(systemName: "person.icloud")
                            .font(.title)
                        Text("Synced Accounts")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    
                }
                Button(action: {
                    print("About tapped!")
                }) {
                    HStack {
                        Image(systemName: "face.smiling")
                            .font(.title)
                        Text("About Us")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    
                }
            }
        }
    }
}
