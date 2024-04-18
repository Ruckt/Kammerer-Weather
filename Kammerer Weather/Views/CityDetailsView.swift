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
    var iconUrl: URL?
    
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
        
        iconUrl = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")
    }
    
    var body: some View {
        VStack {
            Text("\(self.city) is \(self.mainDescription)")
                .font(.headline)
            
            if let url = iconUrl {
                AsyncImageView(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 250)
            }
            Text("Description:  \(self.description)")
                .font(.body)
                .padding()
            Text("Current Temperature: \(weatherData.main.temp)")
                .font(.subheadline)
            Text("Feels Like: \(weatherData.main.feelsLike)")
                .font(.subheadline)
        }
    }
}
