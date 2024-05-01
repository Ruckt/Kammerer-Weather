//
//  OpenWeatherService.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/14/24.
//

import Foundation

protocol OpenWeatherServiceable {
    func getCityWeather(name : String, _ stateCode: String?, _ countryCode: String, _ isFahrenheit: Bool, apiKey: String) async -> (result: Result<OpenWeatherResponse, RequestError>, header: HeaderDictionary?)
}

struct OpenWeatherService: OpenWeatherServiceable, HTTPClient {
    func getCityWeather(name : String, _ stateCode: String?, _ countryCode: String, _ isFahrenheit: Bool, apiKey: String) async -> (result: Result<OpenWeatherResponse, RequestError>, header: HeaderDictionary?) {
        let endpoint = OpenWeatherEndpoint.city(name, stateCode, countryCode, isFahrenheit, key: apiKey)
        return await sendRequest(endpoint: endpoint, responseModel: OpenWeatherResponse.self)
    }
}
