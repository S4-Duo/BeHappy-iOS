//
//  HomeView.swift
//  MoodPredictorIOS
//
//  Created by Reno Muijsenberg on 02/03/2023.
//
import SwiftUI

struct HomeView: View {
    @State private var isCustomCameraViewPresentent = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Button {
                    isCustomCameraViewPresentent = true
                } label: {
                    Text("Navigate Button")
                        .padding()
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
