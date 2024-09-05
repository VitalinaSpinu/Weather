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
    var yOffset: CGFloat = 50
    
    var body: some View {
        VStack {
            Spacer()
            
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
                Text("H: \(viewModel.tempMax)°")
                    .font(.system(size: CGFloat(fontSize)) .weight(.bold))
                    .foregroundStyle(.white)
                Text("L: \(viewModel.tempMin)°")
                    .font(.system(size: CGFloat(fontSize)) .weight(.bold))
                    .foregroundStyle(.white)
            }
            
            VStack {
                Image("House")
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
        }.ignoresSafeArea()
        
        .background {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}
