//
//  WeatherResponse.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/14/24.
//

import Foundation

struct OpenWeatherResponse: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: System
    let timezone, id: Int
    let name: String
    let cod: Int
}

struct Coordinate: Codable {
    let lon, lat: Double
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity, feelsLike = "feels_like", tempMin = "temp_min", tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct System: Codable {
    let type, id: Int?
    let country: String
    let sunrise, sunset: Int
}
