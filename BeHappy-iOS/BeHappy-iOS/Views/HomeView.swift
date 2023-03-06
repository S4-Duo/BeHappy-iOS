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
                Spacer()
                
                Button {
                    isCustomCameraViewPresentent = true
                } label: {
                    Text("Navigate Button")
                }.buttonStyle(.borderedProminent)
            }
            .navigationDestination(isPresented: $isCustomCameraViewPresentent) {
                CustomCameraView(isPresent: $isCustomCameraViewPresentent)
            }.navigationTitle("Goodmorning Brett,")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
