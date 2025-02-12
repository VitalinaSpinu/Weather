//
//  File.swift
//  Weather
//
//  Created by Vitalina Spinu on 15.08.2024.
//

import SwiftUI

struct WeatherModel: Codable {
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

struct WeatherForecastResponse: Codable {
    let list: [WeatherForecast]  
}

struct WeatherForecast: Codable {
    let dt: Int
    let main: ForecastMain
    let weather: [ForecastDescription]
    let pop: Double?
}

struct ForecastMain: Codable {
    let temp: Double
}

struct ForecastDescription: Codable {
    let description: String
    let icon: String
}

