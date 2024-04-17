//
//  CityDetailsView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/16/24.
//

import SwiftUI

struct CityDetailsView: View {
    var weatherData: OpenWeatherResponse?
    
    var body: some View {
        VStack {
            if let weatherData = weatherData {
                Text("Temperature: \(weatherData.main.temp)")
                Text("Feels Like: \(weatherData.main.feelsLike)")
            } else {
                Text("Loading weather data...")
            }
        }
        .navigationTitle("Weather Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
