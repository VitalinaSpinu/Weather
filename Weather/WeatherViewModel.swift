//
//  File.swift
//  Weather
//
//  Created by Vitalina Spinu on 15.08.2024.
//

import SwiftUI
import Alamofire
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(lat: String, lon: String) -> AnyPublisher<WeatherModel, Error>
}

class WeatherViewModel: ObservableObject {
    @Published var tempMax: String = ""
    @Published var tempMin: String = ""
    @Published var temp: String = ""
    @Published var description: String = ""
    @Published var forecastTempsDay: [WeatherForecastDataDay] = []
    @Published var forecastTempsHour: [WeatherForecastDataHour] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    
    private let apiKey: String = "840628f87cbb3df8ea739e55ab09d2eb"
    private let urlForecast: String = "https://api.openweathermap.org/data/2.5/forecast"
    private let urlWeather: String = "https://api.openweathermap.org/data/2.5/weather"
    private let units: String = "metric"
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
        fetchForecast(lat: "47.003670", lon: "28.907089", url: urlForecast)
    }
    
    func loadWeather(lat: String, lon: String) {
        weatherService.fetchWeather(lat: lat, lon: lon)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { weatherData in
                self.tempMax = "\(Int(weatherData.main.temp_max))"
                self.tempMin = "\(Int(weatherData.main.temp_min))"
                self.temp = "\(Int(weatherData.main.temp))"
                self.description = weatherData.weather.first?.description ?? "No Description"
            })
            .store(in: &cancellables)
    }
    
    func weatherIcon(for description: String) -> String {
        switch description.lowercased() {
        case "clear sky":
            return "sun.max.fill"
        case "few clouds":
            return "cloud.sun.fill"
        case "scattered clouds":
            return "cloud.fill"
        case "broken clouds":
            return "cloud.heavyrain.fill"
        case "overcast clouds":
            return "cloud.fill"
        case "light rain", "moderate rain", "heavy rain", "very heavy rain", "extreme rain":
            return "cloud.rain.fill"
        case "light snow", "snow", "heavy snow":
            return "snowflake"
        case "thunderstorm":
            return "cloud.bolt.rain.fill"
        case "mist", "haze", "fog":
            return "cloud.fog.fill"
        case "dust", "sand", "sand, dust whirls":
            return "wind"
        default:
            return "questionmark.circle"
        }
    }
    
    private func processForecastDataDay(_ forecasts: [WeatherForecast]) -> [WeatherForecastDataDay] {
        let processedForecasts = forecasts
            .sorted { $0.dt < $1.dt }
            .map { forecast in
                let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
                let dayOfWeek = dayOfWeek(from: date)
                let description = forecast.weather.first?.description ?? "No Description"
                let temp = String(format: "%d°", Int(forecast.main.temp))
                let icon = weatherIcon(for: description)
                let pop = forecast.pop ?? 0.0
                
                return WeatherForecastDataDay(dateDay: dayOfWeek, description: description, temp: temp, icon: icon, pop: pop)
            }
        
        var seenDays = Set<String>()
        let uniqueForecasts = processedForecasts.filter { forecast in
            if seenDays.contains(forecast.dateDay) {
                return false
            } else {
                seenDays.insert(forecast.dateDay)
                return true
            }
        }
        return uniqueForecasts
    }
    
    func icon(for weatherIcon: String) -> String {
        switch weatherIcon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "questionmark.circle"
        }
    }
    
    private func processForecastDataHour(_ forecasts: [WeatherForecast]) -> [WeatherForecastDataHour] {
        let processedForecasts = forecasts
            .prefix(8)
            .map { forecast in
                let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
                let hour = hour(from: date)
                let description = forecast.weather.first?.description ?? "No Description"
                let temp = String(format: "%d°", Int(forecast.main.temp))
                let icon1 = forecast.weather.first?.icon ?? "No icon"
                let icon2 = icon(for: icon1)
                let pop = forecast.pop ?? 0.0
                
                return WeatherForecastDataHour(dateHour: hour, description: description, temp: temp, icon: icon2, pop: pop)
            }
        return processedForecasts
    }
    
    func fetchForecast(lat: String, lon: String, url: String) {
        let parameters = ["lat": lat, "lon": lon, "units": units, "appid": apiKey]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(WeatherForecastResponse.self, from: data!)
                        DispatchQueue.main.async {
                            self.forecastTempsDay = self.processForecastDataDay(jsonData.list)
                            self.forecastTempsHour = self.processForecastDataHour(jsonData.list)
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func dayOfWeek(from dateDay: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: dateDay)
    }
    
    private func hour(from dateHour: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: dateHour)
    }
}

struct WeatherForecastDataDay {
    let dateDay: String
    let description: String
    let temp: String
    let icon: String
    let pop: Double
}

struct WeatherForecastDataHour: Identifiable {
    let id = UUID()
    let dateHour: String
    let description: String
    let temp: String
    let icon: String
    let pop: Double
}
