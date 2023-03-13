//
//  EmojiPhotoComponent.swift
//  BeHappy-iOS
//
//  Created by Brett Mulder on 13/03/2023.
//

import SwiftUI

struct EmojiPhotoComponent: View {
    let emoji: String
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(Color.white)
            Text(emoji)
                .font(.system(size: 50))
                .foregroundColor(.white)
        }
        .frame(width: 75, height: 75)
    }
}

struct EmojiPhotoComponent_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPhotoComponent(emoji: "😁")
    }
}
