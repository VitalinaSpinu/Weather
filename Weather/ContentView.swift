//
//  ContentView.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    let fontSize = 20
    
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
                    .font(.system(size: CGFloat(fontSize)) .weight(.bold))
                    .foregroundStyle(.gray)
            }
            HStack {
                Spacer()
                Text("H: \(viewModel.tempMax)°")
                    .font(.system(size: CGFloat(fontSize)) .weight(.bold))
                    .foregroundStyle(.white)
                Text("L: \(viewModel.tempMin)°")
                    .font(.system(size: CGFloat(fontSize)) .weight(.bold))
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
