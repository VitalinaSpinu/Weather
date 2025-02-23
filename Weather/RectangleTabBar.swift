//
//  RectangleTabBar.swift
//  Weather
//
//  Created by Vitalina Spinu on 24.09.2024.
//

import SwiftUI

struct RectangleTabBar: View {
    var body: some View {
        let path = Path { path in
    
            let width = UIScreen.main.bounds.width
            let height: CGFloat = 100
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: width, y: 0),
                control1: CGPoint(x: width * 0.25, y: 40),
                control2: CGPoint(x: width * 0.75, y: 40)
            )
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
        path.stroke(Color.RectangleLineBlue, lineWidth: 0.5)
        path.fill(Color.clear)
    }
}
