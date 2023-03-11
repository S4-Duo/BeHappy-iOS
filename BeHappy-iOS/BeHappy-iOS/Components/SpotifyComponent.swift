//
//  SpotifyComponent.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 11/03/2023.
//

import SwiftUI
import SpotifyiOS

struct SpotifyComponent: View {
    var body: some View {
        VStack {
            HStack {
                Text("Spotify")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            Button(action: {
                let playlistURI = "spotify:playlist:3ptJYVlhqy7u493CqpVlEY"
                guard let url = URL(string: playlistURI) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }) {
                Spacer()
                
                Text("Listen to random Spotify Playlist")
                    .padding(10)
                    .font(.title3)
                
                Spacer()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
