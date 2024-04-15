//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .invalidURL:
            return "Unable to successfully create URL from urlComponents."
        case .decode:
            return "Decoding error."
        case .unauthorized:
            return "Unathorized error."
        default:
            return "Unknown error."
        }
    }
}
