//
//  CharacterImageDataProvider.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import BackendInterface
import DependencyInjection
import Foundation
import PortalGunInterface

final class CharacterImageDataProvider: CharacterImageDataProviderInterface {
    @Inject private var client: ClientInterface
    
    func fetchRemoteImage(for character: RMCharacter) async throws -> Data {
        try await client
            .fetch(urlString: character.image)
    }
}
