//
//  GoogleSignInButton.swift
//  MoodPredictorIOS
//
//  Created by Brett Mulder on 02/03/2023.
//
import SwiftUI
import GoogleSignIn


struct GoogleSignInButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack{
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .mask(
                        Circle()
                    ).frame(height: 65)
                Text("Sign in with Google").foregroundColor(Color.black.opacity(0.54)).fontWeight(.semibold).font(.title3)
                Spacer()
            }.background(.white)
        }
        .frame(height: 60)
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .edgesIgnoringSafeArea(.horizontal)
        .cornerRadius(10) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 1)
        ).shadow(radius: 5)
        
    }
}


struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton(action: {})
    }
}
