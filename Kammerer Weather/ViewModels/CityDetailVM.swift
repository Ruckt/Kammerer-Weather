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
    let isFarenheit: Bool
    let getService: GetWeatherService
    
    @Published var weatherData: OpenWeatherResponse
    @Published var mainDescription: String = ""
    @Published var description: String = ""
    @Published var iconUrl: URL?
    
    
    init(name: String, country: String, isFarenheit: Bool, weatherData: OpenWeatherResponse, getService: GetWeatherService) {
        self.name = name
        self.country = country
        self.isFarenheit = isFarenheit
        self.weatherData = weatherData
        self.getService = getService
    
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
        if let response = await getService.fetchWeatherFor(city: name, country: country, isFarenheit: isFarenheit) {
            weatherData = response
            addDetails(weatherData: weatherData)
            print(response)
        }
    }
}
