//
//  Color.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import Foundation
import SwiftUI

extension Color {
//    public static var purpleLightV: Color {
//        return Color(red: 0.28, green: 0.19, blue: 0.62)
//    }
    public static var purpleDarkRectangle: Color {
        return Color(red: 0.18, green: 0.1, blue: 0.42)
    }
//    public static var purpleLinearVertical: LinearGradient {
//        return LinearGradient(gradient: Gradient(colors: [Color.purpleDarkV, Color.purpleLightV]), startPoint: .leading, endPoint: .trailing)
//    }
//    public static var purpleLightH: Color {
//        return Color(red: 0.29, green: 0.29, blue: 0.49)
//    }
    public static var purpleDarkArc: Color {
        return Color(red: 0.18, green: 0.18, blue: 0.39)
    }
//    public static var purpleLinearHorizontal: LinearGradient {
//        return LinearGradient(gradient: Gradient(colors: [Color.purpleLightH, Color.purpleDarkH]), startPoint: .top, endPoint: .bottom)
//    }
    public static var RectangleLineBlue: Color {
        return Color(red: 0.45, green: 0.50, blue: 0.95)
    }
}
extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
