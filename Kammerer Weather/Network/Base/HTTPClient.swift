//
//  ContentView.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

import Foundation

typealias HeaderDictionary = [AnyHashable: Any]

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> (result: Result<T, RequestError>, header: HeaderDictionary?)
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> (result: Result<T, RequestError>, header: HeaderDictionary?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            return (.failure(.invalidURL), nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)

            guard let response = response as? HTTPURLResponse else {
                return (.failure(.noResponse), nil)
            }

            switch response.statusCode {
            case 200 ... 299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return (.failure(.decode), nil)
                }
                return (.success(decodedResponse), response.allHeaderFields)
            case 401:
                return (.failure(.unauthorized), nil)
            case 404:
                return (.failure(.cityNotFound), nil)
            default:
                return (.failure(.unexpectedStatusCode), nil)
            }
        } catch {
            return (.failure(.unknown), nil)
        }
    }
}
