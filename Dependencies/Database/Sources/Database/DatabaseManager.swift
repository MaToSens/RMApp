//
//  DatabaseManager.swift
//  
//
//  Created by MaTooSens on 21/02/2024.
//

import DatabaseInterface
import RealmSwift

fileprivate struct DAOFactory {
    static func initializeObject<DAO: LocalDAOInterface, Object: LocalStorable>(from dao: DAO) -> Object {
        guard let dao = dao as? Object.LocalDAO else {
            fatalError()
        }
        
        return Object(from: dao)
    }
    
    static func initializeDAO<Object: LocalStorable, DAO: LocalDAOInterface>(from object: Object) -> DAO {
        guard let object = object as? DAO.LocalModel else {
            fatalError()
        }
        
        return DAO(from: object)
    }
}

actor DatabaseManager {
    private var realm: Realm?
    
    private func ensureRealmIsOpen() async throws {
        if realm == nil {
            try await initializeRealm()
        }
    }
    
    private func initializeRealm() async throws {
        do {
            self.realm = try await Realm(actor: self)
            print("\nInitialized Realm: \(realm?.configuration.fileURL?.absoluteString ?? "--")\n")
        } catch {
            throw DatabaseManagerError.unableToOpenRealm
        }
    }
}

// MARK: Save
extension DatabaseManager: DatabaseManagerInterface {
    func save<Object: LocalStorable>(_ object: Object) async throws -> Object {
        try await ensureRealmIsOpen()
        let objectDAO: Object.LocalDAO = DAOFactory.initializeDAO(from: object)
        
        do {
            try await realm?.asyncWrite {
                realm?.add(objectDAO, update: .modified)
            }
        } catch {
            throw DatabaseManagerError.unableToSave
        }
        
        return DAOFactory.initializeObject(from: objectDAO)
    }
    
    func save<Object: LocalStorable>(_ objects: [Object]) async throws -> [Object] {
        try await ensureRealmIsOpen()
        let objectsDAO: [Object.LocalDAO] = objects.map { DAOFactory.initializeDAO(from: $0) }
        
        do {
            try await realm?.asyncWrite {
                realm?.add(objectsDAO)
            }
        } catch {
            throw DatabaseManagerError.unableToSave
        }
        
        return objects
    }
    
    func get<Object: LocalStorable>(type: Object.Type, primaryKey: String) async throws -> Object {
        try await ensureRealmIsOpen()

        guard let objectDAO = realm?.object(ofType: Object.LocalDAO.self, forPrimaryKey: primaryKey) else {
            throw DatabaseManagerError.unableToFind
        }

        return DAOFactory.initializeObject(from: objectDAO)
    }

    func getAll<Object: LocalStorable>() async throws -> [Object]  {
        try await ensureRealmIsOpen()
        
        guard let objectsDAO = realm?.objects(Object.LocalDAO.self) else {
            throw DatabaseManagerError.unableToFind
        }
        
        return objectsDAO.map { DAOFactory.initializeObject(from: $0) }
    }
}
