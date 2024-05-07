//
//  GetWeatherServiceMock.swift
//  Kammerer WeatherTests
//
//  Created by Lichtenstein, Edan on 4/24/24.
//


@testable import Kammerer_Weather
import Foundation

struct OpenWeatherServiceMock: OpenWeatherServiceable {
    func getCityWeather(name: String, _ stateCode: String?, _ countryCode: String, _ isFahrenheit: Bool, apiKey: String) async -> (result: Result<Kammerer_Weather.OpenWeatherResponse, Kammerer_Weather.RequestError>, header: Kammerer_Weather.HeaderDictionary?) {

        let fileName = name + (stateCode ?? "") + "Mock"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json")
        else {
            print("Error Loading Mock Path")
            return (.failure(.unknown), nil)
        }
        
        do {
            guard let jsonData = try String(contentsOfFile: path).data(using: .utf8),
               let decodedResponse = try? JSONDecoder().decode(OpenWeatherResponse.self, from: jsonData)
            else {
                return (.failure(.decode), nil)
            }
                    
                
            let headerField = ["field": "value"]
                
            return (.success(decodedResponse), headerField)
            
        } catch {
            return (.failure(.decode), nil)
        }

        
    }
    
}

