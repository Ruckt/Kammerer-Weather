//
//  CityWeatherVM.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/14/24.
//

import Foundation

class CityWeatherVM: ObservableObject {

    let service = OpenWeatherService()

    func fetchWeatherFor(city: String, country: String, isFarenheit: Bool) async ->  OpenWeatherResponse? {
        
        guard let apikey = loadAPIKey()
        else {
            print("Secret plist failed to load")
            return nil
        }
        
        let response = await service.getCityWeather(city: city, countryCode: country, isFarenheit: isFarenheit, apiKey: apikey)

        print(" ** Weather Data **")
        print(response)
        
        switch response.result {
        case let .success(response):
            return response
        case let .failure(error):
            return nil
        }
    }
    
    // Secrets.plist is NOT pushed up to Github.
    func loadAPIKey() -> String? {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            print("Plist file not found")
            return nil
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        let value = plist?.object(forKey: "OpenWeatherApiKey") as? String
        return value
    }
}
