//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//


import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.openweathermap.org"
    }
}
