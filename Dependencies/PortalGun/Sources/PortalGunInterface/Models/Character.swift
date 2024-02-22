//
//  Character.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

public struct RMCharacterResponse: Codable {
    public let info: InfoResponse
    public let results: [CharacterAPI]
}

public struct InfoResponse: Codable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
}

public struct CharacterAPI: Identifiable, Codable {
    public let id: Int
    public let name: String
    public let status: CharacterStatus
    public let species: String
    public let type: String?
    public let gender: String
    public let origin: RMOrigin
    public let location: RMLocation
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}

public enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    public var color: Color {
        switch self {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}
