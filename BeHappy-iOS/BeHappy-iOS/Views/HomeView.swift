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
    
    @StateObject var settings = Settings()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.init(Color(red: 251 / 255, green: 252 / 255, blue: 252 / 255))
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    if settings.isShowGif {
                        AnimatedImageView(mood: "Happy")
                            .padding(10)
                            .frame(height: 250)
                    }
                    
                    if settings.isShowWeather {
                        WeatherCardComponent()
                            .padding(10)
                    }

                    Spacer()
                    
                    Button {
                        isCustomCameraViewPresentent = true
                    } label: {
                        Spacer()
                        Text("Take photo of the day!")
                            .padding(10)
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(10)
                }
                .navigationTitle("Goodmorning Brett,")
                .navigationDestination(isPresented: $isCustomCameraViewPresentent) {
                    CustomCameraView()
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            
            CommunityView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Community")
                }
                
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
