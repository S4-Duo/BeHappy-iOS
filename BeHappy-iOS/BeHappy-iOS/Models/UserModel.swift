//
//  UserModel.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 13/03/2023.
//

import Foundation

struct UserModel: Identifiable {
    let id: String
    let userName: String
    
    init(userId: String, userName: String) {
        self.id = userId
        self.userName = userName
    }
}
