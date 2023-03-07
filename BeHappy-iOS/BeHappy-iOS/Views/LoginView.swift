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
                        .frame(height: UIScreen.main.bounds.width * 1.07)
                        .ignoresSafeArea(.all)
            .edgesIgnoringSafeArea(.all)
            Text("BeHappy").font(.custom(
                "Child\'sHand",
                fixedSize: 40)).frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            GoogleSignInButton {
                FireAuth.share.signInWithGoogle(presenting: getRootViewController()) { error in
                    print("ERROR:  \(String(describing: error))")
                }
            }
        }
        .onAppear() {
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
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
