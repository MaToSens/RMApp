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
}

// MARK: Data Providers Interface
public protocol CharactersDataProviderInterface {
    func fetchCharacterResponse(page: Int) async throws -> RMCharacterResponse
}

public protocol CharacterImageDataProviderInterface {
    func fetchRemoteImage(for character: RMCharacter) async throws -> Data
}
