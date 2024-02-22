//
//  PortalGunInterface.swift
//  
//
//  Created by MaTooSens on 21/02/2024.
//

import SwiftUI

public protocol PortalGunManagerInterface {
    func fetchCharacters(page: Int) async throws -> [RMCharacter]
    func fetchCharacterImage(for character: RMCharacter) async throws -> UIImage
    func updateFavoriteStatus(for character: RMCharacter) async throws -> RMCharacter
    func fetchEpisodes(_ character: RMCharacter) async throws -> [RMEpisode]
    func fetchFavoriteCharacter() async throws -> [RMCharacter]
}

// MARK: Data Providers Interface
public protocol CharactersDataProviderInterface {
    func fetchCharacterResponse(page: Int) async throws -> RMCharacterResponse
}

public protocol CharacterImageDataProviderInterface {
    func fetchRemoteImage(for character: RMCharacter) async throws -> Data
}

public protocol CharacterEpisodeDataProviderInterface {
    func fetchCharacterEpisodes(character: RMCharacter) async throws -> [RMEpisode]
}
