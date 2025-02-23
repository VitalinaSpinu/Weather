//
//  Mok.swift
//  Weather
//
//  Created by Vitalina Spinu on 12.02.2025.
//

import Combine
import Foundation

class MockWeatherService: WeatherServiceProtocol {
    var shouldReturnError = false
    var mockWeatherData: WeatherModel!
    
    func fetchWeather(lat: String, lon: String) -> AnyPublisher<WeatherModel, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            return Just(mockWeatherData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
