//
//  WeatherViewController.swift
//  WeatherREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        // Escolha as cores usando o valor hexadecimal
        let startColor = UIColor(red: 73/255.0, green: 91/255.0, blue: 144/255.0, alpha: 1.0)
        let endColor = UIColor(red: 3/255.0, green: 41/255.0, blue: 68/255.0, alpha: 1.00)
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // Ponto de início do gradiente (canto superior esquerdo)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0) // Ponto de fim do gradiente (canto inferior direito)
        
        // Adicione o gradiente como subcamada da UIView
        gradientView.layer.addSublayer(gradientLayer)
        
        let city = "Florestal" // Substitua pela cidade desejada
        
        WeatherAPI.getWeatherData(forCity: city) { [weak self] weatherData, error in
            if let error = error {
                // Lidar com o erro
                print("Error fetching weather data: \(error)")
            } else if let weatherData = weatherData {
                DispatchQueue.main.async {
                    self?.cityNameLabel.text = weatherData.name.uppercased()
                    
                    let formattedTemperature = String(format: "%.1f", weatherData.temperatureCelsius)
                    self?.temperatureLabel.text = "\(formattedTemperature) °C"
                    self?.weatherDescriptionLabel.text = weatherData.weather.first?.description.camelCase ?? "N/A"
                    // Obter o dia da semana para o timestamp atual
                    let currentTimestamp = Date().timeIntervalSince1970
                    let dayOfWeek = getDayOfWeek(fromTimestamp: currentTimestamp)
                    self?.weekLabel.text = dayOfWeek.camelCase
                }
            }
        }
    }
}
