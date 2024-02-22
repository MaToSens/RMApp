//
//  BackendInterface.swift
//  
//
//  Created by MaTooSens on 21/02/2024.
//

import Foundation

public protocol ClientInterface {
    func fetch(urlString: String) async throws -> Data
    func fetch<Endpoint: EndpointInterface, Response: Decodable>(endpoint: Endpoint) async throws -> Response
    func fetchObjects<Endpoint: EndpointInterface, Response: Decodable>(endpoint: Endpoint) async throws -> [Response]
}

public protocol EndpointInterface {
    var components: [String] { get }
    var parameters: [String: Any] { get }
    static var base: String { get }
}

public enum HTTPError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidDecoding(Error)
    case invalidParameters
}
