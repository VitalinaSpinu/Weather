//
//  File.swift
//  Weather
//
//  Created by Vitalina Spinu on 15.08.2024.
//

import SwiftUI
import Alamofire

class WeatherViewModel: ObservableObject {
    
    @Published var tempMax: String = ""
    @Published var tempMin: String = ""
    @Published var temp: String = ""
    @Published var description: String = ""
    
    private let apiKey: String = "4f071ac6d017b2bdfc07918768d91cb3"
    private let url: String = "https://api.openweathermap.org/data/2.5/weather"
    private let units: String = "metric"
    
    init() {
        fetchWeather(lat: "47.003670", lon: "28.907089")
    }
    
    func fetchWeather(lat: String, lon: String) {
        
        let parameters = ["lat": lat, "lon": lon, "units": units, "appid": apiKey]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(WeatherDto.self, from: data!)
                        DispatchQueue.main.async {
                            self.tempMax = "\(jsonData.main.temp_max)"
                            self.tempMin = "\(jsonData.main.temp_min)"
                            self.temp = "\(jsonData.main.temp)"
                            self.description = jsonData.weather.first?.description ?? "No Description"
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
