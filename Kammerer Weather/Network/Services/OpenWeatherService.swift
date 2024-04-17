//
//  OpenWeatherService.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/14/24.
//

import Foundation

protocol OpenWeatherServiceable {
    func getCityWeather(city: String, countryCode: String, isFarenheit: Bool, apiKey: String) async -> (result: Result<OpenWeatherResponse, RequestError>, header: HeaderDictionary?)
}

struct OpenWeatherService: OpenWeatherServiceable, HTTPClient {
    func getCityWeather(city: String, countryCode: String, isFarenheit: Bool, apiKey: String) async -> (result: Result<OpenWeatherResponse, RequestError>, header: HeaderDictionary?) {
        let endpoint = OpenWeatherEndpoint.city(city, country: countryCode, isFarenheit: isFarenheit, key: apiKey)
        return await sendRequest(endpoint: endpoint, responseModel: OpenWeatherResponse.self)
    }
}
