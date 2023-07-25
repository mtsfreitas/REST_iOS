//
//  WeatherData.swift
//  WeatherREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

struct WeatherData: Decodable {
    let name: String
    let main: MainWeatherData
    let weather: [WeatherDescription]

    struct MainWeatherData: Decodable {
        let temp: Double
        // Outros campos relevantes para o clima principal
    }

    struct WeatherDescription: Decodable {
        let description: String
        let icon: String
        // Outros campos relevantes para a descrição do clima
    }

    var temperatureCelsius: Double {
        return main.temp - 273.15
    }
}




