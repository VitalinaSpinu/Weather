//
//  ContentView.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    let fontSizeTextWeather = 20
    let fontSizeButtonTabBar = 22
    @State private var showBottomSheet = true
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 5) {
                    Text("Chișinǎu")
                        .font(.system(size: 34) .weight(.regular))
                        .foregroundStyle(.white)
                    Text("\(viewModel.temp)°")
                        .font(.system(size: 96) .weight(.thin))
                        .foregroundStyle(.white)
                        .frame(height: 70)
                    Text(viewModel.description)
                        .font(.system(size: CGFloat(fontSizeTextWeather)) .weight(.bold))
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Text("H: \(viewModel.tempMax)°")
                            .font(.system(size: CGFloat(fontSizeTextWeather)) .weight(.bold))
                            .foregroundStyle(.white)
                        Text("L: \(viewModel.tempMin)°")
                            .font(.system(size: CGFloat(fontSizeTextWeather)) .weight(.bold))
                            .foregroundStyle(.white)
                    }
                }
                
                ZStack {
                    Image("House")
                        .resizable()
                        .scaledToFit()
                    ZStack(alignment: .bottom) {
                        SheetView(iconWeatherDescription: "")
                        ZStack {
                            RectangleTabBar()
                            ZStack {
                                ArcTabBar()
                                HStack {
                                    Button {
                                    } label: {
                                        Image(systemName: "mappin.and.ellipse")
                                            .foregroundStyle(.white)
                                            .font(.system(size: CGFloat(fontSizeButtonTabBar)))
                                    }
                                    Spacer()
                                    Button {
                                    } label: {
                                        Image(systemName: "list.star")
                                            .foregroundStyle(.white)
                                            .font(.system(size: CGFloat(fontSizeButtonTabBar)))
                                    }
                                }.padding(.horizontal, 50)
                            }
                        }.frame(height: 100)
                    }.offset(y: UIScreen.main.bounds.height / 2 - 270)
                }
                
            }
        }
    }
}
