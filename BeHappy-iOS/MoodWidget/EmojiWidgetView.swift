//
//  EmojiWidgetView.swift
//  MoodWidgetExtension
//
//  Created by Brett Mulder on 13/03/2023.
//

import SwiftUI

struct EmojiWidgetView: View {
    let emoji: String
    let mood: String
    var body: some View {
        ZStack {
            Color(UIColor.systemIndigo)
            VStack {
                Text(emoji)
                    .font(.system(size: 56))
                Text(mood)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding([.leading, .trailing])
                    .foregroundColor(.white)
            }
        }
    }
}

struct EmojiWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiWidgetView(emoji: "😁", mood: "Happy")
    }
}
