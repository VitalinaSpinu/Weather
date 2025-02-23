//
//  File.swift
//  Weather
//
//  Created by Vitalina Spinu on 15.08.2024.
//

import SwiftUI

struct WeatherModel: Codable {
    let main: MainWeather
    let weather: [WeatherDescription]
}

struct MainWeather: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct WeatherDescription: Codable {
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

