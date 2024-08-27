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
    public static var purpleLinearVertical: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.purpleDarkV, Color.purpleLightV]), startPoint: .leading, endPoint: .trailing)
    }
    public static var purpleLightH: Color {
        return Color(red: 0.32, green: 0.35, blue: 0.54)
    }
    public static var purpleDarkH: Color {
        return Color(red: 0.16, green: 0.14, blue: 0.41)
    }
    public static var purpleLinearHorizontal: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.purpleLightH, Color.purpleDarkH]), startPoint: .top, endPoint: .bottom)
    }
}
