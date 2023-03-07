//
//  ContentView.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 13/02/2023.
//
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct LoginView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("smiley")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .frame(height: UIScreen.main.bounds.width * 1)
                        .ignoresSafeArea(.all)
            .edgesIgnoringSafeArea(.all)
            Text("BeHappy").font(Font.largeTitle.weight(.bold)).frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            GoogleSignInButton {
                FireAuth.share.signInWithGoogle(presenting: getRootViewController()) { error in
                    print("ERROR:  \(String(describing: error))")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding().background(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
