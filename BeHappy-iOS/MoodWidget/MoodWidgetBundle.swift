//
//  MoodWidgetBundle.swift
//  MoodWidget
//
//  Created by Brett Mulder on 13/03/2023.
//

import WidgetKit
import SwiftUI

@main
struct MoodWidgetBundle: WidgetBundle {
    var body: some Widget {
        MoodWidget()
        MoodWidgetLiveActivity()
    }
}
