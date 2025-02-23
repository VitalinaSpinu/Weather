//
//  ArcTabBar.swift
//  Weather
//
//  Created by Vitalina Spinu on 24.09.2024.
//

import SwiftUI

struct ArcTabBar: View {
    
    let innerShadowsCircle: CGFloat = 64
    @State private var isShow = false

    var body: some View {
        ZStack(alignment: .center) {
            let path = Path { path in
                let width = UIScreen.main.bounds.width
                let halfWidth = width / 2
                let transitionX = 90
                let startPointY = 100
                let controlPointYBottom = 70
                let controlPointYTop = 0
                let topLine = 34 / 2
                let curveDistance = 75
            
                path.move(to: CGPoint(x: transitionX, y: startPointY)) // Start point
                path.addCurve(to: CGPoint(x: Int(halfWidth) - topLine, y: .zero),
                              control1: CGPoint(x: transitionX + curveDistance, y: controlPointYBottom),
                              control2: CGPoint(x: Int(halfWidth) - curveDistance, y: controlPointYTop))
                path.addLine(to: CGPoint(x: Int(halfWidth) + topLine, y: .zero)) // Middle line
                path.addCurve(to: CGPoint(x: Int(width) - transitionX, y: startPointY),
                              control1: CGPoint(x: Int(halfWidth) + curveDistance, y: controlPointYTop),
                              control2: CGPoint(x: Int(width) - transitionX - curveDistance, y: controlPointYBottom))
                path.closeSubpath()
            }
            path.fill(Color.purpleDarkArc).overlay(path.stroke(Color.black, lineWidth: 1))
            
            ZStack(alignment: .center) {
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
