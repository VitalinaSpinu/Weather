//
//  Color.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    public static var purpleDarkRectangle: Color {
        return Color(red: 0.18, green: 0.1, blue: 0.42)
    }
    public static var purpleDarkArc: Color {
        return Color(red: 0.18, green: 0.18, blue: 0.39)
    }
    public static var RectangleLineBlue: Color {
        return Color(red: 0.45, green: 0.50, blue: 0.95)
    }
}
extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
