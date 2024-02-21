//
//  DatabaseInterface.swift
//  
//
//  Created by MaTooSens on 21/02/2024.
//

import Foundation
import RealmSwift

public protocol LocalDAOInterface: Object {
    associatedtype LocalModel: LocalStorable
    init(from: LocalModel)
}

public protocol LocalStorable: Codable, Equatable  {
    associatedtype LocalDAO: LocalDAOInterface
    init(from: LocalDAO)
}

public protocol DatabaseManagerInterface {
    func save<Object: LocalStorable>(_ object: Object) async throws -> Object
    func save<Object: LocalStorable>(_ objects: [Object]) async throws -> [Object]
    func get<Object: LocalStorable>(type: Object.Type, primaryKey: String) async throws -> Object
    func getAll<Object: LocalStorable>() async throws -> [Object]
}

public protocol FileStorageManagerInterface {
    func save(
        data: Data,
        folderName: String,
        fileName: String,
        withExtension fileExtension: String
    ) throws
    
    func retrieve(
        folderName: String,
        fileName: String,
        withExtension fileExtension: String
    ) throws -> Data
}

public enum FileStorageManagerError: Error {
    case unableToAccessURL
    case unableToConvertToData(Error)
    case unableToCreateDirectory
    case unableToFind
    case unableToSave
}

public enum DatabaseManagerError: Error {
    case unableToOpenRealm
    case unableToSave
    case unableToFind
    case unableToUpdate
    case unableToDelete
}
