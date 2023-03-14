//
//  CommunityView.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 08/03/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CommunityView: View {
    let db = Firestore.firestore()
    
    @State var users = [UserModel]()
    @State var friendsList = [FriendModel]()
    
    
    var body: some View {
        VStack {
            Text("Users").font(.title)
            List {
                ForEach(users) { user in
                    if user.id != Auth.auth().currentUser!.uid {
                        HStack {
                            Text(user.userName)
                            Spacer()

                            if friendsList.first(where: { $0.id == user.id }) != nil {
                                Button(action: {
                                     removeFriend(friendId: user.id)
                                }, label: {
                                    Text("Remove")
                                        .padding(10)
                                })
                                .buttonStyle(.borderedProminent)
                            } else {
                                Button(action: {
                                     addFriend(friendId: user.id)
                                }, label: {
                                    Text("Follow")
                                        .padding(10)
                                })
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            getAllUsers()
            getAllFriends()
        }
    }
    
    private func getAllUsers() {
        users = [] ///Set array empty so it does not duplicate
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let userId = document.documentID
                    let data = document.data()
                    
                    let user = UserModel(userId: userId, userName: data["userName"] as? String ?? "")
                    
                    users.append(user)
                }
            }
        }
    }
    
    private func getAllFriends() {
        friendsList = [] ///Set array empty so it does not duplicate
        
        if let currentUser = Auth.auth().currentUser {
            db.collection("friends").document(currentUser.uid).getDocument { (document, error) in
                if let error = error {
                    print("Error getting document: \(error)")
                } else if let document = document, document.exists {
                    if let friendsArray = document.data()?["friends"] as? [String] {
                        let friendPaths = friendsArray.map { $0 }
                        
                        for id in friendPaths {
                            friendsList.append(FriendModel(friendId: id))
                        }
                    } else {
                        print("friendsRef field is missing or not an array")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    private func addFriend(friendId: String) {
        var friendIdList = [String]()
        friendsList.append(FriendModel(friendId: friendId))
        
        for friendId in friendsList {
            friendIdList.append(friendId.id)
        }
        
        if let currentUser = Auth.auth().currentUser {
            db.collection("friends").document(currentUser.uid).setData(["friends": friendIdList])
        }
    }
    
    private func removeFriend(friendId: String) {
        var friendIdList = [String]()
        
        friendsList.removeAll { $0.id == friendId }
        
        for friendId in friendsList {
            friendIdList.append(friendId.id)
        }
        
        if let currentUser = Auth.auth().currentUser {
            db.collection("friends").document(currentUser.uid).setData(["friends": friendIdList])
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
