//
//  MoodStore.swift
//  BeHappy-iOS
//
//  Created by Brett Mulder on 13/03/2023.
//

import Foundation
import SwiftUI
import Combine


class MoodStore: ObservableObject {
    @AppStorage("mood") var mood = "Happy"
    @AppStorage("emoji") var emoji = "😔"

}
