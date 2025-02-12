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
    @Published var forecastTempsDay: [WeatherForecastDataDay] = []
    @Published var forecastTempsHour: [WeatherForecastDataHour] = []
    
    private let apiKey: String = "840628f87cbb3df8ea739e55ab09d2eb"
    private let urlForecast: String = "https://api.openweathermap.org/data/2.5/forecast"
    private let urlWeather: String = "https://api.openweathermap.org/data/2.5/weather"
    private let units: String = "metric"
    
    init() {
        fetchWeather(lat: "47.003670", lon: "28.907089", url: urlWeather)
        fetchForecast(lat: "47.003670", lon: "28.907089", url: urlForecast)
    }
    
    func fetchWeather(lat: String, lon: String, url: String) {
        let parameters = ["lat": lat, "lon": lon, "units": units, "appid": apiKey]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(WeatherModel.self, from: data!)
                        DispatchQueue.main.async {
                            self.tempMax = "\(Int(jsonData.main.temp_max))"
                            self.tempMin = "\(Int(jsonData.main.temp_min))"
                            self.temp = "\(Int(jsonData.main.temp))"
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
    
    func weatherIcon(for description: String) -> String {
        switch description.lowercased() {
        case "clear sky":
            return "sun.max.fill" // Cer senin
        case "few clouds":
            return "cloud.sun.fill" // Câteva nori
        case "scattered clouds":
            return "cloud.fill" // Nori risipiți
        case "broken clouds":
            return "cloud.heavyrain.fill" // Nori înfrânți
        case "overcast clouds":
            return "cloud.fill" // Cer acoperit de nori
        case "light rain", "moderate rain", "heavy rain", "very heavy rain", "extreme rain":
            return "cloud.rain.fill" // Ploaie
        case "light snow", "snow", "heavy snow":
            return "snowflake" // Zăpadă
        case "thunderstorm":
            return "cloud.bolt.rain.fill" // Furtună
        case "mist", "haze", "fog":
            return "cloud.fog.fill" // Ceață
        case "dust", "sand", "sand, dust whirls":
            return "wind" // Vânt cu praf sau nisip
        default:
            return "questionmark.circle" // Dacă nu este recunoscută descrierea, folosim un simbol de întrebarea
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
        // Set pentru a urmări zilele deja procesate și pentru a elimina duplicatele
        var seenDays = Set<String>() // Set pentru a urmări zilele deja procesate
        let uniqueForecasts = processedForecasts.filter { forecast in
            // Dacă ziua nu a fost deja procesată, o adăugăm
            if seenDays.contains(forecast.dateDay) {
                return false // Dacă ziua există deja, o excludem
            } else {
                seenDays.insert(forecast.dateDay) // Adăugăm ziua în set
                return true
            }
        }
        return uniqueForecasts
    }
    
    func icon(for weatherIcon: String) -> String {
        switch weatherIcon {
        case "01d": return "sun.max.fill"          // Cer senin zi
        case "01n": return "moon.fill"            // Cer senin noapte
        case "02d": return "cloud.sun.fill"       // Parțial noros zi
        case "02n": return "cloud.moon.fill"      // Parțial noros noapte
        case "03d", "03n": return "cloud.fill"    // Noros
        case "04d", "04n": return "smoke.fill"    // Cer complet acoperit de nori
        case "09d", "09n": return "cloud.drizzle.fill" // Ploaie măruntă
        case "10d": return "cloud.sun.rain.fill"  // Ploaie zi
        case "10n": return "cloud.moon.rain.fill" // Ploaie noapte
        case "11d", "11n": return "cloud.bolt.fill" // Furtună
        case "13d", "13n": return "snow"          // Zăpadă
        case "50d", "50n": return "cloud.fog.fill" // Ceață
        default: return "questionmark.circle"     // Cod necunoscut
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
