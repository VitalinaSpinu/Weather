//
//  Color.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    public static var purpleLightV: Color {
        return Color(red: 0.28, green: 0.19, blue: 0.62)
    }
    public static var purpleDarkV: Color {
        return Color(red: 0.19, green: 0.17, blue: 0.36)
    }
    public static var linearVertical: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.purpleDarkV, Color.purpleLightV]), startPoint: .leading, endPoint: .trailing)
    }
    public static var purpleLightH: Color {
        return Color(red: 0.42, green: 0.45, blue: 0.74)
    }
    public static var purpleDarkH: Color {
        return Color(red: 0.26, green: 0.24, blue: 0.51)
    }
    public static var linearHorizontal: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.purpleLightH, Color.purpleDarkH]), startPoint: .top, endPoint: .bottom)
    }
}
