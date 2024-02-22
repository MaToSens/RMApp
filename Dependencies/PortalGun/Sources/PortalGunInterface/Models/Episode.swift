//
//  Episode.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import Foundation

public struct RMEpisode: Identifiable, Codable{
    public let id: Int
    public let name: String
    public let airDate: String
    public let episode: String
    public let characters: [String]
    public let url: String
    public let created: String
    
    public init(
        id: Int,
        name: String,
        airDate: String,
        episode: String,
        characters: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }

    public static let sample = RMEpisode(
        id: 1,
        name: "Pilot",
        airDate: "December 2, 2013",
        episode: "S01E01",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2"
        ],
        url: "https://rickandmortyapi.com/api/episode/1",
        created: "2017-11-10T12:56:33.798Z"
    )
}
