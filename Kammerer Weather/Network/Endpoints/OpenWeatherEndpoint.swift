//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

import Foundation

enum OpenWeatherEndpoint {
    case city(_ city: String, country:String, key: String)
}

extension OpenWeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .city:
            return "/data/2.5/weather"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .city:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .city:
            return [
                "Content-Type": "application/json;charset=utf-8",
            ]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .city(city, country, key):
            return [URLQueryItem(name: "q", value: "\(city),\(country)"),
                    URLQueryItem(name: "APPID", value: "\(key)")]
        }
    }

    var body: [String: String]? {
        switch self {
        case .city:
            return nil
        }
    }
}
