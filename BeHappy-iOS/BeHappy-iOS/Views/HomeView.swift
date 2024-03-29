//
//  HomeView.swift
//  MoodPredictorIOS
//
//  Created by Reno Muijsenberg on 02/03/2023.
//
import SwiftUI
import Firebase

struct HomeView: View {
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresentent = false
        
    @StateObject var settings = Settings()
    @StateObject var moodStore = MoodStore()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.init(Color(red: 251 / 255, green: 252 / 255, blue: 252 / 255))
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    VStack {
                        Text("Predicted mood:")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 18)
                        Text("\(moodStore.mood)")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 18)
                        
                        Button {
                            isCustomCameraViewPresentent = true
                        } label: {
                            Spacer()
                            Text("Take photo of the day!")
                                .padding(10)
                                .font(.title3)
                            Spacer()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(10)
                        
                        if settings.isShowGif {
                            AnimatedImageComponent()
                                .padding(10)
                                .padding(.top, -10)
                                .frame(height: 250)
                            
                            Spacer().frame(height: 20)
                        }
                        
                        if settings.isShowSpotify {
                            SpotifyComponent()
                                .padding(10)
                                .padding(.top, -10)
                        }
                        
                        if settings.isShowWeather {
                            WeatherCardComponent()
                                .padding(10)
                                .padding(.top, -10)
                        }
                        
                        if settings.isShowHeartRate {
                            HeartRateComponent()
                                .padding(10)
                                .padding(.top, -10)
                        }
                    }
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .navigationTitle("Goodmorning \(Auth.auth().currentUser?.displayName!.components(separatedBy: " ")[0] ?? ""),")
                .navigationDestination(isPresented: $isCustomCameraViewPresentent) {
                    CameraView()
                }
            }
            

            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            
            ExploreView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
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
