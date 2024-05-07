//
//  CityDetailVM.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/17/24.
//

import Foundation

class CityDetailVM: ObservableObject{
  
    let name: String
    let country: String
    let stateCode: String?

    let isFahrenheit: Bool
    let getService: GetWeatherService
    
    @Published var temperature: Double
    @Published var feelsLike: Double
    @Published var mainDescription: String = ""
    @Published var description: String = ""
    @Published var iconUrl: URL?
    @Published var errorMessage: String = ""
    
    init(cityData: CityData, weatherService: GetWeatherService) {
        self.name = cityData.city
        self.stateCode = cityData.state
        self.country = cityData.country
        self.temperature = cityData.weatherData.main.temp
        self.feelsLike = cityData.weatherData.main.feelsLike
        self.isFahrenheit = cityData.isFahrenheit
        self.getService = weatherService
    
        self.mainDescription = cityData.mainDescription
        self.description = cityData.description
        self.iconUrl = URL(string: "https://openweathermap.org/img/wn/\(cityData.icon)@2x.png")
    }

    
    @MainActor
    func refreshWeather() async {
        let package = await getService.fetchWeatherFor(name, stateCode, country, isFahrenheit)
        
        if let response = package.response {
            errorMessage = ""
          
            temperature = response.main.temp
            feelsLike = response.main.feelsLike
            mainDescription = response.weather[0].main
            description = response.weather[0].description
            
            let icon = response.weather[0].icon
            iconUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
            
        } else if let message = package.error {
            errorMessage = message
        }
    }
}
