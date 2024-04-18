//
//  CityDetailsView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/16/24.
//

import SwiftUI

struct CityDetailsView: View {
    var weatherData: OpenWeatherResponse
    
    let city: String
    
    let mainDescription: String
    let description: String
    let iconId: String
    
    init(city: String,
         weatherData: OpenWeatherResponse) {

        self.city = city
        self.weatherData = weatherData
        
        let details = weatherData.weather[0]
        mainDescription = details.main
        description = details.description
        iconId = details.icon
        
        print(" *** ")
        print(weatherData)
    }
    
    var body: some View {
        VStack {
            Text("Temperature: \(weatherData.main.temp)")
            Text("Feels Like: \(weatherData.main.feelsLike)")
            Text("Description:  \(self.description)")
            Text("Icon:  \(self.iconId)")
        }
        .navigationTitle("\(self.city) is \(self.mainDescription)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
