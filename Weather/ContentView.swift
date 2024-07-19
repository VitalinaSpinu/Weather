//
//  ContentView.swift
//  Weather
//
//  Created by Dmitrii Vrabie on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Chisinau")
                .font(.system(size: 34).weight(.regular))
                .foregroundStyle(.white)
        }
        .background {
            Image("")
        }
    }
}

#Preview {
    ContentView()
}
