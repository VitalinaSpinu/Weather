//
//  ArcTabBar.swift
//  Weather
//
//  Created by Vitalina Spinu on 24.09.2024.
//

import SwiftUI

struct ArcTabBar: View {
    
    let innerShadowsCircle: CGFloat = 64

    var body: some View {
        ZStack {
            let path = Path { path in
                let width = 405
                let halfWidth = width / 2
                let height = 100
                let transitionX = 90
                let startPointY = 100
                let controlPointYBottom = 70
                let controlPointYTop = 0
                let topLine = 34
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
            path.fill(Color.purpleDarkArc).overlay(path.stroke(Color.black, lineWidth: 1))
            
            ZStack {
                Circle()
                    .fill(Color.purpleDarkArc)
                    .frame(width: innerShadowsCircle, height: innerShadowsCircle)
                    .shadow(color: Color.white.opacity(0.3), radius: 10, x: -10, y: -10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                    )
                Button("") {
                }.buttonStyle(ButtonPlusStyle())
            }
        }
    }
}
