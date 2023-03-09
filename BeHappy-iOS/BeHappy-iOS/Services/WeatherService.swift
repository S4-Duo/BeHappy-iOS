//
//  WeatherService.swift
//  BeHappy-iOS
//
//  Created by Reno Muijsenberg on 09/03/2023.
//

import Foundation

class WeatherService {
    let apiKey = "10d75ce922ba55bf2abd1dae42d58e54"
    let units = "metric"
    
    func fetchTemperature(city: String, completionHandler: @escaping (Double?, String?) -> Void) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(units)&appid=\(apiKey)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    completionHandler(nil, error.localizedDescription)
                    return
                }
                
                // Check for a successful response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(nil, "Invalid response")
                    return
                }
                
                // Check that we received data
                guard let data = data else {
                    completionHandler(nil, "No data received")
                    return
                }
                
                // Parse the JSON response
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Update the temperature with the data
                        if let main = json["main"] as? [String: Any],
                           let temp = main["temp"] as? Double {
                            completionHandler(temp, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func fetchWeatherType(city: String, completionHandler: @escaping (String?, String?) -> Void) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(units)&appid=\(apiKey)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    completionHandler(nil, error.localizedDescription)
                    return
                }
                
                // Check for a successful response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(nil, "Invalid response")
                    return
                }
                
                // Check that we received data
                guard let data = data else {
                    completionHandler(nil, "No data received")
                    return
                }
                
                // Parse the JSON response
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Update the weather type with the data
                        if let weatherArray = json["weather"] as? [[String: Any]],
                           let weather = weatherArray.first,
                           let description = weather["description"] as? String {
                            completionHandler(description, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func fetchWeatherImage(city: String, completionHandler: @escaping (String?, String?) -> Void) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(units)&appid=\(apiKey)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    completionHandler(nil, error.localizedDescription)
                    return
                }
                
                // Check for a successful response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    completionHandler(nil, "Invalid response")
                    return
                }
                
                // Check that we received data
                guard let data = data else {
                    completionHandler(nil, "No data received")
                    return
                }
                
                // Parse the JSON response
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Update the weather type with the data
                        if let weatherArray = json["weather"] as? [[String: Any]],
                           let weather = weatherArray.first,
                           let icon = weather["icon"] as? String {
                            completionHandler(icon, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
