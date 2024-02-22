//
//  File.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import BackendInterface
import DependencyInjection
import Foundation
import PortalGunInterface

fileprivate struct Endpoint: EndpointInterface {
    let components: [String]
    let parameters: [String : Any]
    static let base: String = "/character/"
    
    init(page: Int) {
        self.components = []
        self.parameters = [
            "page": page
        ]
    }
}

final class CharactersDataProvider: CharactersDataProviderInterface {
    @Inject private var client: ClientInterface
    
    func fetchCharacterResponse(page: Int) async throws -> RMCharacterResponse {
        try await client.fetch(endpoint: Endpoint(page: page))
    }
}

