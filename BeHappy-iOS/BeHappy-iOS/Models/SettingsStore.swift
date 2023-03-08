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
    @AppStorage("showWeather") var isShowWeather = false
    @AppStorage("showGif") var isShowGif = false
    @AppStorage("showSpotify") var isShowSpotify = true
}
