//
//  EpisodeDataProvider.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import PortalGunInterface
import BackendInterface
import DependencyInjection
import Foundation

fileprivate struct Endpoint: EndpointInterface {
    let components: [String]
    let parameters: [String : Any]
    static let base: String = "/episode"
    
    init(ids: [String]) {
        self.components = [ids.joined(separator: ",")]
        self.parameters = [:]
    }
}

final class CharacterEpisodeDataProvider: CharacterEpisodeDataProviderInterface {
    @Inject private var client: ClientInterface
    
    func fetchCharacterEpisodes(character: RMCharacter) async throws -> [RMEpisode] {
        let ids = extractIds(from: character)
        return try await client.fetchObjects(endpoint: Endpoint(ids: ids))
    }
    
    private func extractIds(from character: RMCharacter) -> [String] {
        character
            .episode
            .compactMap {
                $0.replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "")
            }
    }
}
