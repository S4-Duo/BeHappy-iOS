//
//  HomeView.swift
//  MoodPredictorIOS
//
//  Created by Reno Muijsenberg on 02/03/2023.
//
import SwiftUI

struct HomeView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresentent = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button (
                    action: {
                        FireAuth.share.signOutFromGoogle()
                    },
                    label: {
                        Text("Sign out").padding(10)
                    }
                ).buttonStyle(.borderedProminent).padding(.bottom)
                Spacer()
                
                Button {
                    isCustomCameraViewPresentent = true
                } label: {
                    Text("Navigate Button")
                        .padding(10)
                }
                .buttonStyle(.borderedProminent)
                
            }
            .navigationTitle("Goodmorning Brett,")
            .navigationDestination(isPresented: $isCustomCameraViewPresentent) {
                  CustomCameraView()
             }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
