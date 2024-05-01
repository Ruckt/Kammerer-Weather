//
//  ContentViewVM.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/30/24.
//

import Foundation

class ContentViewVM: ObservableObject{
    
    var weatherService: GetWeatherService
    
    init() {
        weatherService = GetWeatherService()
    }
    
    @MainActor
    func fetchWeatherFor(city: String, _ stateCode: String?, _ countryCode: String, _ isFahrenheit: Bool) async -> (response: OpenWeatherResponse?, error: String?) {
        
        guard !city.isEmpty
        else {
            let message = "Did you forget the city name?"
            return (nil, message)
        }
        
        let package = await weatherService.fetchWeatherFor(city, stateCode, countryCode, isFahrenheit)
        if let wd = package.response {
    
            return (wd, nil)
        } else if let message = package.error {
            return (nil, message)
        } else {
            let message = "An unknown error occured. Please try again."
            return (nil, message)
        }
    }
}
