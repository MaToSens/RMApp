//
//  Client.swift
//  
//
//  Created by MaTooSens on 21/02/2024.
//

import BackendInterface
import Foundation

final class Client: ClientInterface {
    func fetch(urlString: String) async throws -> Data {
        try await URLSession.downloadData(urlString)
    }
    
    func fetch<Endpoint: EndpointInterface, Response: Decodable>(endpoint: Endpoint) async throws -> Response {
        let data = try await URLSession.downloadData(endpoint: endpoint)
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    func fetchObjects<Endpoint: EndpointInterface, Response: Decodable>(endpoint: Endpoint) async throws -> [Response] {
        let data = try await URLSession.downloadData(endpoint: endpoint)
        let decoder = JSONDecoder(withKeyDecodingStrategy: .convertFromSnakeCase)
        
        return try decoder.decode([Response].self, from: data)
    }
}

