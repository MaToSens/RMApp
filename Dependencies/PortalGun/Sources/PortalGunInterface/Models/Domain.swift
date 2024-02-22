//
//  Domain.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import DatabaseInterface
import Foundation

public struct RMCharacter: Identifiable, LocalStorable {
    public let id: Int
    public let name: String
    public let status: CharacterStatus
    public let species: String
    public let type: String?
    public let gender: String
    public let origin: RMOrigin?
    public let location: RMLocation?
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
    public let isFavorite: Bool
    
    public init(
        id: Int,
        name: String,
        status: CharacterStatus,
        species: String,
        type: String?,
        gender: String,
        origin: RMOrigin,
        location: RMLocation,
        image: String,
        episode: [String],
        url: String,
        created: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
        self.isFavorite = isFavorite
    }
    
    public init(from api: CharacterAPI) {
        self.id = api.id
        self.name = api.name
        self.status = api.status
        self.species = api.species
        self.type = api.type
        self.gender = api.gender
        self.origin = api.origin
        self.location = api.location
        self.image = api.image
        self.episode = api.episode
        self.url = api.url
        self.created = api.created
        self.isFavorite = false
    }
    
    public init(from dao: RMCharacterDAO) {
        self.id = dao.id
        self.name = dao.name
        self.status = CharacterStatus(rawValue: dao.status) ?? .unknown
        self.species = dao.species
        self.type = dao.type
        self.gender = dao.gender
        self.origin = RMOrigin(from: dao.origin ?? RMOriginDAO())
        self.location = RMLocation(from: dao.location ?? RMLocationDAO())
        self.image = dao.image
        self.episode = dao.episode.map { $0 }
        self.url = dao.url
        self.created = dao.created
        self.isFavorite = dao.isFavorite
    }
}

public struct RMOrigin: LocalStorable {
    public let name: String
    public let url: String
    
    public init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
    
    public init(from dao: RMOriginDAO) {
        self.name = dao.name
        self.url = dao.url
    }
}

public struct RMLocation: LocalStorable {
    public let name: String
    public let url: String
    
    public init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
    
    public init(from dao: RMLocationDAO) {
        self.name = dao.name
        self.url = dao.url
    }
}
