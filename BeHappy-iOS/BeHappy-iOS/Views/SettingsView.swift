//
//  SettingsView.swift
//  BeHappy-iOS
//
//  Created by Brett Mulder on 08/03/2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings = Settings()
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("Homescreen")) {
                        Toggle("Show Gif", isOn: $settings.isShowGif)
                        Toggle("Show Weather", isOn: $settings.isShowWeather)
                        Toggle("Show Spotify", isOn: $settings.isShowSpotify)
                        Toggle("Show Heart Rate", isOn: $settings.isShowHeartRate)
                    }
                    
                }
                .navigationTitle("Settings")
                Spacer()
                Button (
                    action: {
                        FireAuth.share.signOutFromGoogle()
                    },
                    label: {
                        Text("Sign out").padding(10).foregroundColor(.red)
                    }
                )
            }
        }
        
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
