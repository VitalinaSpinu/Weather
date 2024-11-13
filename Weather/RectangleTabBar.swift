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
            
            let pointX = 440
            let pointY = -10
            let control2PointX = 300
            let control1PointX = 130
            let controlPointY = 45
            let linePointY = 110
            
            path.move(to: .zero)
            path.addCurve(to: CGPoint(x: pointX, y: pointY),
                          control1: CGPoint(x: control1PointX, y: controlPointY),
                          control2: CGPoint(x: control2PointX, y: controlPointY))
            path.addLine(to: CGPoint(x: pointX, y: linePointY))
            path.addLine(to: CGPoint(x: pointY, y: linePointY))
            path.closeSubpath()
        }
        path.stroke(Color.RectangleLineBlue, lineWidth: 0.7)
        path.fill(Color.purpleDarkRectangle.opacity(0.7))
    }
}
