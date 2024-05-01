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
    let isFarenheit: Bool
    let getService: GetWeatherService
    
    @Published var weatherData: OpenWeatherResponse
    @Published var mainDescription: String = ""
    @Published var description: String = ""
    @Published var iconUrl: URL?
    @Published var errorMessage: String = ""
    
    
    init(name: String, stateCode: String?, country: String, isFarenheit: Bool, weatherData: OpenWeatherResponse, weatherService: GetWeatherService) {
        self.name = name
        self.stateCode = stateCode
        self.country = country
        self.isFarenheit = isFarenheit
        self.weatherData = weatherData
        self.getService = weatherService
    
        self.addDetails(weatherData: weatherData)
    }
    
    func addDetails(weatherData: OpenWeatherResponse) {
        let details = weatherData.weather[0]
        self.mainDescription = details.main
        self.description = details.description
        
        let iconId = details.icon
        self.iconUrl = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")
    }
    
    @MainActor
    func refreshWeather() async {
        let package = await getService.fetchWeatherFor(name, stateCode, country, isFarenheit)
        
        if let response = package.response {
            weatherData = response
            errorMessage = ""
            addDetails(weatherData: weatherData)
        } else if let message = package.error {
            errorMessage = message
        }
    }
}
