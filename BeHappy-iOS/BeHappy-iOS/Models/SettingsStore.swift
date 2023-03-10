//
//  SettingsStore.swift
//  BeHappy-iOS
//
//  Created by Brett Mulder on 08/03/2023.
//

import Foundation
import SwiftUI
import Combine


class Settings: ObservableObject {
    @AppStorage("showGif") var isShowGif = true
    @AppStorage("showWeather") var isShowWeather = true
    @AppStorage("showSpotify") var isShowSpotify = false
    @AppStorage("showHeartRate") var isShowHeartRate = true
}
