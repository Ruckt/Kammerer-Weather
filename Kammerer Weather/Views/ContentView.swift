//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

import SwiftUI

struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
    
    @State private var cityName: String = ""

    var body: some View {
        VStack {
            TextField("Enter city name", text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            PrettyButton {
                print("Fetching weather for \(cityName)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
