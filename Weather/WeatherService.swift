//
//  WeatherService.swift
//  Weather
//
//  Created by Vitalina Spinu on 12.02.2025.
//

import Alamofire
import Combine

struct WeatherService: WeatherServiceProtocol {
    private let apiKey = "840628f87cbb3df8ea739e55ab09d2eb"
    private let units = "metric"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(lat: String, lon: String) -> AnyPublisher<WeatherModel, Error> {
        let parameters = ["lat": lat, "lon": lon, "units": units, "appid": apiKey]
        
        return Future<WeatherModel, Error> { promise in
            AF.request(self.baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .validate()
                .responseDecodable(of: WeatherModel.self) { response in
                    switch response.result {
                    case .success(let weatherData):
                        promise(.success(weatherData))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
