//
//  URLSession+Extension.swift
//
//
//  Created by MaTooSens on 21/02/2024.
//

import BackendInterface
import Foundation

fileprivate struct PathBuilder {
    private static let baseURLString: String = "https://rickandmortyapi.com/api"
    
    static func buildURL<Endpoint: EndpointInterface>(endpoint: Endpoint) throws -> URL {
        let path = buildPath(from: endpoint)
        
        guard let url = URL(
            string: baseURLString.appending(path),
            with: endpoint.parameters
        ) else {
            throw HTTPError.invalidParameters
        }
        
        print("URL: ", url)
        return url
    }
    
    private static func buildPath<Endpoint: EndpointInterface>(from endpoint: Endpoint) -> String {
        var components = endpoint.components
        components.insert(Endpoint.base, at: 0)
        
        return components.joined(separator: "/")
    }
}

extension URLSession {
    static func downloadData(_ urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        return try await fetchData(from: url)
    }
    
    static func downloadData<Endpoint: EndpointInterface>(endpoint: Endpoint) async throws -> Data {
        let url = try PathBuilder.buildURL(endpoint: endpoint)
        return try await fetchData(from: url)
    }
    
    private static func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        return try validateResponse(data: data, response: response)
    }
    
    private static func validateResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw HTTPError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
}

