//
//  WeatherAPI.swift
//  WeatherREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

import Foundation

class WeatherAPI {
    static let apiKey = "APIKEY"
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
}
