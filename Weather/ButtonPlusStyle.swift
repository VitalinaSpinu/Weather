//
//  TogglePlus.swift
//  Weather
//
//  Created by Vitalina Spinu on 24.09.2024.
//

import SwiftUI

struct ButtonPlusStyle: ButtonStyle {
    
    let outerShadowsGreatCircle: CGFloat = 58
    let innerShadowsSmallCircle: CGFloat = 52
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.white)
                            .frame(width: outerShadowsGreatCircle, height: outerShadowsGreatCircle)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                        Circle()
                            .fill(Color.white)
                            .frame(width: innerShadowsSmallCircle, height: innerShadowsSmallCircle)
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
                    } else {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 58, height: 58)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                         )
                    }
                    Image(systemName: "plus")
                        .foregroundStyle(Color.purpleDarkRectangle)
                        .font(.system(size: 26)).bold()
                }
            )
       }
}
