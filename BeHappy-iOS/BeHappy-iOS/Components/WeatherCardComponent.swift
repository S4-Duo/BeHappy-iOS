//
//  WeatherCardComponent.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 09/03/2023.
//

import SwiftUI

struct WeatherCardComponent: View {
    let weatherService = WeatherService()
    
    @State private var temperature: Double?
    @State private var weatherDescription: String?
    @State private var imageLink: URL?

    var body: some View {
        VStack {
            HStack {
                Text("Weather")
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            
            HStack {
                AsyncImage(url: imageLink)
                Spacer()
                VStack {
                    Text("\(Int(round(temperature ?? 0)))°C")
                        .font(.title3)
                    Text("\(weatherDescription ?? "")")
                        .font(.title3)
                }
                .padding(.trailing, 20)
            }
            .background(.white)
            .cornerRadius(10)
        }
        .onAppear() {
            weatherService.fetchTemperature(city: "Maasbree") { temperature, error in
                if let temperature = temperature {
                    DispatchQueue.main.async {
                        self.temperature = temperature
                    }
                } else if let error = error {
                    print("Error: \(error)")
                }
            }
            
            weatherService.fetchWeatherType(city: "Maasbree") { weatherType, error in
                if let weatherType = weatherType {
                    DispatchQueue.main.async {
                        self.weatherDescription = weatherType
                    }
                } else if let error = error {
                    print("Error: \(error)")
                }
            }
            
            weatherService.fetchWeatherImage(city: "Maasbree") { weatherImage ,error in
                if let weatherImage = weatherImage {
                    DispatchQueue.main.async {
                        self.imageLink = URL(string: "https://openweathermap.org/img/wn/\(weatherImage)@2x.png")
                    }
                } else if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct WeatherCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCardComponent()
    }
}
