//
//  ArcTabBar.swift
//  Weather
//
//  Created by Vitalina Spinu on 24.09.2024.
//

import SwiftUI

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
