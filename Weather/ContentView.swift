//
//  ContentView.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("Chișinǎu")
                    .font(.system(size: 34) .weight(.regular))
                    .foregroundStyle(.white)
                Text("\(viewModel.temp)°")
                    .font(.system(size: 96) .weight(.thin))
                    .foregroundStyle(.white)
                    .frame(height: 70)
                Text(viewModel.description)
                    .font(.system(size: 20) .weight(.bold))
                    .foregroundStyle(.gray)
            }
            HStack {
                Spacer()
                Text("H: \(viewModel.tempMax)°")
                    .font(.system(size: 20) .weight(.bold))
                    .foregroundStyle(.white)
                Text("L: \(viewModel.tempMin)°")
                    .font(.system(size: 20) .weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
            }
            VStack {
                Image("House")
                    .resizable()
                    .scaledToFit()
            }
        }
        .background {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}
class WeatherViewModel: ObservableObject {
    
    @Published var tempMax: String = "-"
    @Published var tempMin: String = "-"
    @Published var temp: String = "-"
    @Published var description: String = "-"
    
    init() {
        fetchWeather()
    }
    func fetchWeather() {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let apiKey:String = "4f071ac6d017b2bdfc07918768d91cb3"
        let lat = "47.003670"
        let lon = "28.907089"
        let units = "metric"
        let parameters = ["lat": lat, "lon": lon, "units": units, "appid": apiKey]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(WeatherDto.self, from: data!)
                        print(jsonData)
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

