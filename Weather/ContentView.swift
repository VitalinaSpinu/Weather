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
            ZStack {
                RectangleTabBar()
                ZStack {
                    ArcTabBar()
                    HStack {
                        Button {
                        } label: {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundStyle(.white)
                                .font(.system(size: 28))
                        }
                        Spacer()
                        Button {
                        } label: {
                            Image(systemName: "list.star")
                                .foregroundStyle(.white)
                                .font(.system(size: 28))
                        }
                    }.padding(.horizontal, 50)
                }
            }.frame(height: 100)
        }.ignoresSafeArea()
        
            .background {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
        }
    }
}

struct RectangleTabBar: View {
    var body: some View {
        let path = Path { path in
            path.move(to: .zero)
            path.addCurve(to: CGPoint(x: 440, y: -10),
                control1: CGPoint(x: 130, y: 45),
                control2: CGPoint(x: 300, y: 45))
            path.addLine(to: CGPoint(x: 440, y: 110))
            path.addLine(to: CGPoint(x: -10, y: 110))
            path.closeSubpath()
        }
        path.fill(Color.purpleLinearVertical).overlay(path.stroke(Color.white, lineWidth: 0.5))
    }
}

struct ArcTabBar: View {
    
    @State private var isToggled = false
    
    var body: some View {
        ZStack {
            let path = Path { path in
                let width = 430
                let halfWidth = width / 2
                let height = 100
                let transitionX = 90
                let startPointY = 100
                let controlPointYBottom = 75
                let controlPointYTop = 0
                let topLine = 54
                let curveDistance = 75
                
                path.move(to: CGPoint(x: transitionX, y: startPointY)) // Start point
                path.addCurve(to: CGPoint(x: halfWidth - topLine / 2, y: .zero),
                    control1: CGPoint(x: transitionX + curveDistance, y: controlPointYBottom),
                    control2: CGPoint(x: halfWidth - curveDistance, y: controlPointYTop))
                path.addLine(to: CGPoint(x: halfWidth + topLine / 2, y: .zero)) // Middle line
                path.addCurve(to: CGPoint(x: width - transitionX, y: startPointY),
                    control1: CGPoint(x: halfWidth + curveDistance, y: controlPointYTop),
                    control2: CGPoint(x: width - transitionX - curveDistance, y: controlPointYBottom))
                path.closeSubpath()
            }
            path.fill(Color.purpleLinearHorizontal).overlay(path.stroke(Color.black, lineWidth: 1))
            
            ZStack {
                Circle()
                    .fill(Color.purpleLinearHorizontal)
                    .frame(width: 76, height: 76)
                    .overlay(
                    Circle()
                        .stroke(Color.purpleLinearHorizontal, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask(Circle().fill(LinearGradient(Color.white, Color.clear)))
                    )
                    .overlay(
                    Circle()
                        .stroke(Color.purpleLinearHorizontal, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask(Circle().fill(LinearGradient(Color.black, Color.clear))))
                Circle()
                    .fill(Color.purpleLinearHorizontal)
                    .frame(width: 74, height: 74)
                    .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 6)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                    )
                    .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                    )
                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                Toggle(isOn: $isToggled) {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.purpleLinearVertical)
                        .imageScale(.large)
                        .font(.title2).bold()
                }
                .toggleStyle(TogglePlus())
            }
        }
    }
}
struct TogglePlus: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        }
            .background(
                Group {
                    if configuration.isOn {
                        Circle()
                            .fill(Color.whiteOff)
                            .frame(width: 66, height: 66)
                            .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 6)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 6)
                                .blur(radius: 4)
                                .offset(x: -2, y: -2)
                                .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(Color.whiteOff)
                            .frame(width: 66, height: 66)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                    }
                     
                }
            ).animation(nil, value: UUID())
    }
}
