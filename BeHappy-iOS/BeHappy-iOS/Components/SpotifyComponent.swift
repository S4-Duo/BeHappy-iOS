//
//  SpotifyComponent.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 11/03/2023.
//

import SwiftUI
import SpotifyiOS

struct SpotifyComponent: View {
    @StateObject var moodStore = MoodStore()
    @State var spotifyUrl = ""
    
    let happy = [
        "5WNp38fTDt0Ek3FKYYZ75a",
        "0F0vphj4Yxo2mnTdK7DfvY",
        "37i9dQZF1DWWeNODNe68OF",
        "3Pd8XujmlDXexETXoZ4zLm",
        "7dJWq33s3htP3unnuNDArB",
        "37i9dQZF1DX5wgkIjaIMie",
        "37i9dQZF1DX21sNa02ZMU9",
        "561jaB14Bmj62AbpQ4hNER",
        "07Z2A6OsSvy7iX3mpULYjp",
    ]
    
    let neutral = [
        "37i9dQZEVXbKCF6dqVpDkS",
        "37i9dQZF1DWTmvXBN4DgpA",
        "37i9dQZF1EQncLwOalG3K7",
        "6mtYuOxzl58vSGnEDtZ9uB",
        "37i9dQZF1DX0XUsuxWHRQd",
        "4riovLwMCrY3q0Cd4e0Sqp",
        "37i9dQZF1EQoqCH7BwIYb7",
        "0L3CyZ90B6csQ50jb0idrL",
        "37i9dQZF1DWTbCTQUrf6sj",
        "37i9dQZF1DWV7EzJMK2FUI",
    ]
    
    let sad = [
        "089xdhaaBHniaxca44NVXV",
        "2HE3DS5NwRXICj7cLTfdjb",
        "1juwJZUFKQ0rxRXfk5qjuc",
        "73vH2s27Mraz5OMHmy44Zu",
        "41BLA1pe3Hu0twOLlPO3Z9",
        "2LcnEqO9cr3u8Y4Erlyl3s",
        "6qObG1W9sUfXJXyJ31fD0w",
        "1ra4mA18XMapktFxgp0bpv",
        "44tRfteJJzAmUONSiA56bQ",
        "6SHb6gz0M7edrOk9q47y9D"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Spotify")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            Button(action: {
                let playlistURI = "spotify:playlist:\(spotifyUrl)"
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
        .onAppear {
            switch moodStore.mood {
                case "Happy":
                spotifyUrl = happy.randomElement()!
                case "Neutral":
                spotifyUrl = neutral.randomElement()!
                case "Sad":
                spotifyUrl = sad.randomElement()!
            default:
                break
            }
        }
    }
}
