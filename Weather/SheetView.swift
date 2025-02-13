//
//  Untitled.swift
//  Weather
//
//  Created by Vitalina Spinu on 15.11.2024.
//

import SwiftUI

struct SheetView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    var iconWeatherDescription: String
    @State private var isFlagged = false
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.black.opacity(0.4))
                .frame(width: 48, height: 5)
                .padding(.top, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 48, height: 5)
                        .offset(x: 2, y: 5)
                )
            HStack {
                Button {
                    isFlagged = false
                    withAnimation {
                        selectedTab = 0
                    }
                } label: {
                    Text("Hourly Forecast")
                        .frame(width: 125, height: 20)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Button {
                    isFlagged = true
                    withAnimation {
                        selectedTab = 1
                    }
                } label: {
                    Text("Weekly Forecast")
                        .frame(width: 130, height: 20)
                        .foregroundStyle(Color.gray)
                }
            }
            .padding(.bottom, 0)
            .frame(height: 30, alignment: .bottom)
            .padding(.horizontal, 20)
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0),
                                Color.purple.opacity(0.7),
                                Color.white.opacity(0) 
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 150, height: 3)
                    .shadow(color: Color.white.opacity(0.6), radius: 3, x: 3, y: 0)
                    .offset(x: selectedTab == 0 ? -120 : 120)
                    .animation(.easeInOut, value: selectedTab)
                
                
                Divider()
                    .frame(height: 1)
                    .overlay(.black.opacity(0.4))
                    .overlay(
                        Divider()
                            .frame(height: 1)
                            .overlay(.white.opacity(0.2))
                            .offset(x: -1, y: -1)
                    )
            }
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    if isFlagged {
                        ForEach(viewModel.forecastTempsDay, id: \.dateDay) { forecast in
                            VStack(spacing: 12) {
                                Text(forecast.dateDay.uppercased() == viewModel.forecastTempsDay.first?.dateDay.uppercased() ? "TODAY" : forecast.dateDay.uppercased())
                                    .font(.system(size: 15).weight(.bold))
                                    .foregroundStyle(.white)
                                VStack(spacing: 0) {
                                    Image(systemName: forecast.icon)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                    Text(forecast.pop > 0 ? "\(Int(forecast.pop * 100))%" : "")
                                        .font(.system(size: 15).weight(.bold))
                                        .foregroundStyle(.blue)
                                }
                                Text(forecast.temp)
                                    .font(.system(size: 20).weight(.bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 60, height: 146)
                            .background(forecast.dateDay == viewModel.forecastTempsDay.first?.dateDay ? Color.purplelight.opacity(0.8) : Color.purpleDarkRectangle.opacity(0.3))
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.8), radius: 10, x: 5, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                    .shadow(color: Color.white.opacity(0.9), radius: 0, x: 1, y: 1)
                                    .blendMode(.overlay)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            )
                        }
                    } else {
                        ForEach(viewModel.forecastTempsHour) { forecast in
                            VStack(spacing: 12) {
                                Text(forecast.dateHour == viewModel.forecastTempsHour.first?.dateHour ? "NOW" : forecast.dateHour)
                                    .font(.system(size: 15).weight(.bold))
                                    .foregroundStyle(.white)
                                VStack(spacing: 0) {
                                    Image(systemName: forecast.icon)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                    Text(forecast.pop > 0 ? "\(Int(forecast.pop * 100))%" : "")
                                        .font(.system(size: 15).weight(.bold))
                                        .foregroundStyle(.blue)
                                }
                                Text(forecast.temp)
                                    .font(.system(size: 20).weight(.bold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 60, height: 146)
                            .background(forecast.dateHour == viewModel.forecastTempsHour.first?.dateHour ? Color.purplelight.opacity(0.8) : Color.purpleDarkRectangle.opacity(0.3))
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.8), radius: 10, x: 5, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                    .shadow(color: Color.white.opacity(0.9), radius: 0, x: 1, y: 1)
                                    .blendMode(.overlay)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            )
                        }
                    }
                }.padding(.vertical, 20)
            }
            .padding(.horizontal, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 335, alignment: .top)
        .background(Image("Rectangle").resizable().scaledToFill())
        .edgesIgnoringSafeArea(.bottom)
    }
}
