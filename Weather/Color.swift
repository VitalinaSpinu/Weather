//
//  Color.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    public static var solid: Color {
        return Color(red: 0.28, green: 0.19, blue: 0.62)
    }
    public static var solidDark: Color {
        return Color(red: 0.19, green: 0.17, blue: 0.36)
    }
    public static var linear: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.solid, Color.solidDark]), startPoint: .leading, endPoint: .trailing)
    }
}
