//
//  CityDetailVM.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/17/24.
//

import Foundation

class CityDetailVM {
  
    let name: String
    let country: String
    let isFarenheit: Bool
    
    var weatherData: OpenWeatherResponse
    var mainDescription: String = ""
    var description: String = ""
    var iconUrl: URL?
    
    
    init(name: String, country: String, isFarenheit: Bool, weatherData: OpenWeatherResponse) {
        self.name = name
        self.country = country
        self.isFarenheit = isFarenheit
        self.weatherData = weatherData
    
        self.addDetails(weatherData: weatherData)
    }
    
    func addDetails(weatherData: OpenWeatherResponse) {
        let details = weatherData.weather[0]
        self.mainDescription = details.main
        self.description = details.description
        
        let iconId = details.icon
        self.iconUrl = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")
    }
    
}
