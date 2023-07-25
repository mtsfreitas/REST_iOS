//
//  StringExtension.swift
//  WeatherREST
//
//  Created by Matheus Freitas Martins on 25/07/23.
//

import Foundation

extension String {
    var camelCase: String {
        let words = self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        let capitalized = words.map { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }
        let result = capitalized.joined(separator: " ") // Adicionamos o espaço aqui
        return result
    }
}

func getDayOfWeek(fromTimestamp timestamp: Double) -> String {
    let date = Date(timeIntervalSince1970: timestamp)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE" // Obtém o dia da semana (por extenso) em formato "Monday", "Tuesday", etc.
    let dayOfWeek = dateFormatter.string(from: date)
    return dayOfWeek
}


