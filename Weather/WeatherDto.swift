//
//  File.swift
//  Weather
//
//  Created by Vitalina Spinu on 15.08.2024.
//

import SwiftUI

struct WeatherDto: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp_max: Double
    let temp_min: Double
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
