//
//  DAO.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import DatabaseInterface
import RealmSwift

public final class RMCharacterDAO: Object, LocalDAOInterface {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var name: String
    @Persisted public var status: String
    @Persisted public var species: String
    @Persisted public var type: String?
    @Persisted public var gender: String
    @Persisted public var origin: RMOriginDAO?
    @Persisted public var location: RMLocationDAO?
    @Persisted public var image: String
    @Persisted public var episode: List<String>
    @Persisted public var url: String
    @Persisted public var created: String
    @Persisted public var isFavorite: Bool
    
    /// This initializer is required by Realm and should not be used directly to create objects.
    override public init() {
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
        self.origin = RMOriginDAO()
        self.location = RMLocationDAO()
        self.image = ""
        self.episode = List<String>()
        self.url = ""
        self.created = ""
        self.isFavorite = true
    }
    
    public init(from model: RMCharacter) {
        super.init()
        self.id = model.id
        self.name = model.name
        self.status = model.status.rawValue
        self.species = model.species
        self.type = model.type
        self.gender = model.gender
        self.origin = RMOriginDAO(from: model.origin ?? RMOrigin())
        self.location = RMLocationDAO(from: model.location ?? RMLocation())
        self.image = model.image
        self.episode = List<String>()
        self.url = model.url
        self.created = model.created
        self.isFavorite = true
        
        self.episode.append(objectsIn: model.episode)
    }
}


public final class RMOriginDAO: Object, LocalDAOInterface {
    @Persisted public var name: String
    @Persisted public var url: String
    
    override init() {
        self.name = ""
        self.url = ""
    }
    
    public init(from model: RMOrigin) {
        super.init()
        self.name = model.name
        self.url = model.url
    }
}


public final class RMLocationDAO: Object, LocalDAOInterface {
    @Persisted public var name: String
    @Persisted public var url: String
    
    override init() {
        self.name = ""
        self.url = ""
    }
    
    public init(from model: RMLocation) {
        super.init()
        self.name = model.name
        self.url = model.url
    }
}
