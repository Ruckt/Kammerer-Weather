//
//  ContentViewVM.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/30/24.
//

import Foundation

struct CityData {
    let city: String
    let state: String?
    let country: String
    let isFahrenheit: Bool
    
    let mainDescription: String
    let description: String
    let icon: String
    
    let weatherData: OpenWeatherResponse
}

class ContentViewVM: ObservableObject{
    
    var weatherService: GetWeatherService
    
    init() {
        weatherService = GetWeatherService()
    }
    
    @MainActor
    func fetchWeatherFor(city: String, _ stateCode: String?, _ countryCode: String, _ isFahrenheit: Bool) async -> (cityData: CityData?, error: String?) {
        
        guard !city.isEmpty
        else {
            let message = "Did you forget the city name?"
            return (nil, message)
        }
        
        let package = await weatherService.fetchWeatherFor(city, stateCode, countryCode, isFahrenheit)
        if let wd = package.response {
            let cd = CityData(city: city,
                              state: stateCode,
                              country: countryCode,
                              isFahrenheit: isFahrenheit,
                              mainDescription: wd.weather[0].main,
                              description: wd.weather[0].description,
                              icon: wd.weather[0].icon,
                              weatherData: wd)
                
            return (cd, nil)
        } else if let message = package.error {
            return (nil, message)
        } else {
            let message = "An unknown error occured. Please try again."
            return (nil, message)
        }
    }
}
