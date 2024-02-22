//
//  PortalGunManager.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import Database
import DatabaseInterface
import DependencyInjection
import PortalGunInterface
import SwiftUI

final class PortalGunManager: PortalGunManagerInterface {
    @Inject private var fileStorageManager: FileStorageManagerInterface
    @Inject private var charactersDataProvider: CharactersDataProviderInterface
    @Inject private var characterImageDataProvider: CharacterImageDataProviderInterface
    
    private let charactersCache = Cache<[RMCharacter]>(method: .inMemory)
    private let favoriteCharacterCache = Cache<[Int: RMCharacter]>(method: .onDisk)
    
    private let folderName = "images"
    private let fileExtension = ".png"
    private var currentPage: Int = 0
}

// MARK: Fetch characters
extension PortalGunManager {
    func fetchCharacters(page: Int) async throws -> [RMCharacter] {
        if currentPage >= page {
            return try await charactersCache.getAll()
        } else {
            currentPage = page
            return try await fetchRemoteCharacters(page: page)
        }
    }
    
    private func fetchRemoteCharacters(page: Int) async throws -> [RMCharacter] {
        let databaseCharacters = try await favoriteCharacterCache.getAll()
        
        let apiCharacters = try await charactersDataProvider
            .fetchCharacterResponse(page: page)
            .results
            .map { RMCharacter(from: $0) }
        
        let characters = apiCharacters.map { apiCharacter in
            databaseCharacters.first { $0.id == apiCharacter.id } ?? apiCharacter
        }
        
        try await charactersCache.store(characters)
        
        return characters
    }
}

// MARK: Fetch character image
extension PortalGunManager {
    func fetchCharacterImage(for character: RMCharacter) async throws -> UIImage {
        do {
            return try fetchLocalImage(for: character)
        } catch {
            let data = try await characterImageDataProvider.fetchRemoteImage(for: character)
            return try saveImage(data, character: character)
        }
    }
    
    private func fetchLocalImage(for character: RMCharacter) throws -> UIImage {
        let data = try fileStorageManager.retrieve(
            folderName: folderName,
            fileName: String(describing: character.id),
            withExtension: fileExtension
        )
        
        return try dataToImage(data: data)
    }
    
    private func saveImage(_ data: Data, character: RMCharacter) throws -> UIImage {
        try fileStorageManager.save(
            data: data,
            folderName: folderName,
            fileName: String(describing: character.id),
            withExtension: fileExtension
        )
        
        return try dataToImage(data: data)
    }
    
    private func dataToImage(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        return image
    }
}
