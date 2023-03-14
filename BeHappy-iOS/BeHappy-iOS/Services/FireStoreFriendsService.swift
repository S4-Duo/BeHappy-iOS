//
//  FireStoreFriendsService.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 14/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class FireStoreFriendsService {
    let db = Firestore.firestore()
    
    func getAllUsers(completion: @escaping ([UserModel]) -> Void) {
        var users = [UserModel]()
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let userId = document.documentID
                    let data = document.data()
                    
                    let user = UserModel(userId: userId, userName: data["userName"] as? String ?? "")
                    
                    users.append(user)
                }
                
                completion(users)
            }
        }
    }
    
    func getAllFriends(completion: @escaping ([FriendModel]) -> Void) {
        var friendsList = [FriendModel]() ///Set array empty so it does not duplicate

        if let currentUser = Auth.auth().currentUser {
            db.collection("friends").document(currentUser.uid).getDocument { (document, error) in
                if let error = error {
                    print("Error getting document: \(error)")
                    return
                } else if let document = document, document.exists {
                    if let friendsArray = document.data()?["friends"] as? [String] {
                        let friendPaths = friendsArray.map { $0 }

                        for id in friendPaths {
                            friendsList.append(FriendModel(friendId: id))
                        }
                        
                        completion(friendsList)
                    } else {
                        print("friends field is missing or not an array")
                        return
                    }
                } else {
                    print("Document does not exist")
                    return
                }
            }
        }
    }
    
    func removeFriend(friendId: String, friendsList: [FriendModel], completion: @escaping ([FriendModel]) -> Void) {
        var friendsListCopy = friendsList // Create a mutable copy of the input array
        
        friendsListCopy.removeAll { $0.id == friendId } // Modify the mutable copy
        
        var friendIdList = [String]()
        for friend in friendsListCopy {
            friendIdList.append(friend.id)
        }

        if let currentUser = Auth.auth().currentUser {
            db.collection("friends").document(currentUser.uid).setData(["friends": friendIdList])
        }
        
        completion(friendsListCopy)
    }
    
    func addFriend(friendId: String, friendsList: [FriendModel], completion: @escaping ([FriendModel]) -> Void) {
        var friendsListCopy = friendsList
        
        friendsListCopy.append(FriendModel(friendId: friendId))

        var friendIdList = [String]()
        for friend in friendsListCopy {
            friendIdList.append(friend.id)
        }

        if let currentUser = Auth.auth().currentUser {
            db.collection("friends").document(currentUser.uid).setData(["friends": friendIdList])
        }
        
        completion(friendsListCopy)
    }
}
