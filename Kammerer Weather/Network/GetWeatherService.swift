//
//  CityWeatherVM.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/14/24.
//

import Foundation

class GetWeatherService: ObservableObject {

    let service = OpenWeatherService()
    
    var key = ""

    func fetchWeatherFor(_ city: String, _ stateCode: String?, _ country: String, _ isFahrenheit: Bool) async ->  (response: OpenWeatherResponse?, error: String?) {
        
        if key.isEmpty {
            key = loadAPIKey() ?? ""
        }
        
        guard !key.isEmpty
        else {
            let message = ("There is a problem retrieving the Open Weather Token ")
            return (nil, message)
        }
        
        let response = await service.getCityWeather(name: city, stateCode, country, isFahrenheit, apiKey: key)
        
        switch response.result {
        case let .success(response):
            return (response, nil)
        case let .failure(error):
            return (nil, error.customMessage)
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
