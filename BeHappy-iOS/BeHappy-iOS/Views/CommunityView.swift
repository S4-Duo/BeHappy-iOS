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
    let friendsService = FireStoreFriendsService()
    
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
                                    friendsService.removeFriend(friendId: user.id, friendsList: friendsList) { friends in
                                        friendsList = friends
                                    }
                                }, label: {
                                    Text("Remove")
                                        .padding(10)
                                        .foregroundColor(.red)
                                })
                            } else {
                                Button(action: {
                                    friendsService.addFriend(friendId: user.id, friendsList: friendsList) { friends in
                                        friendsList = friends
                                    }
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
            friendsService.getAllUsers() { usersList in
                users = usersList
            }
            friendsService.getAllFriends() { friends in
                friendsList = friends
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
