//
//  FriendModel.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 13/03/2023.
//

import Foundation

struct FriendModel: Identifiable {
    let id: String
    
    init(friendId: String) {
        self.id = friendId
    }
}
