//
//  TogglePlus.swift
//  Weather
//
//  Created by Vitalina Spinu on 24.09.2024.
//

import SwiftUI

struct TogglePlus: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        }
            .background(
                Group {
                    if configuration.isOn {
                        Circle()
                            .fill(Color.whiteOff)
                            .frame(width: 66, height: 66)
                            .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 6)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 6)
                                .blur(radius: 4)
                                .offset(x: -2, y: -2)
                                .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(Color.whiteOff)
                            .frame(width: 66, height: 66)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
                    }
                }
            ).animation(nil, value: UUID())
    }
}
