//
//  WeatherAPI.swift
//  WeatherREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

import Foundation
import UIKit

class WeatherAPI {
    static let apiKey = "API_KEY"
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    static func getWeatherData(forCity city: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        let urlString = "\(baseURL)?q=\(city)&lang=pt_br&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    static func getWeatherIcon(iconCode: String, completion: @escaping (UIImage?) -> Void) {
        let iconURLString = "https://openweathermap.org/img/w/\(iconCode).png"
        guard let iconURL = URL(string: iconURLString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: iconURL) { data, _, error in
            if let error = error {
                print("Error fetching weather icon: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
