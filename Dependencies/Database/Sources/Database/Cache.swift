//
//  Cache.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import DatabaseInterface
import Foundation

public final class Cache<Data: Cacheable> {
    public enum Method {
        case inMemory
        case onDisk
    }
    
    private var method: Method
    private var data: Data
    private let databaseManager = DatabaseManager()
    
    public init(method: Method) {
        self.method = method
        self.data = .empty
    }
}

// MARK: Array support
public extension Cache {
    func store<Element: LocalStorable & Identifiable>(_ data: Data) async throws -> Data where Data == Array<Element> {
        switch method {
        case .inMemory:
            storeInMemory(data)
        case .onDisk:
            try await storeOnDisk(data)
        }
    }
    
    private func storeInMemory<Element: Identifiable>(_ data: Data) -> Data where Data == Array<Element> {
        for element in data {
            if let index = self.data.firstIndex { $0.id == element.id } {
                self.data[index] = element
            } else {
                self.data.append(element)
            }
        }
        
        return self.data
    }
    
    private func storeOnDisk<Element: LocalStorable>(_ data: Data) async throws -> Data where Data == Array<Element> {
        return try await databaseManager.save(data)
    }
    
    func getAll<Element: LocalStorable>() async throws -> Data where Data == Array<Element> {
        switch method {
        case .inMemory:
            return try retrieveFromMemory()
        case .onDisk:
            return try await retrieveFromDisk()
        }
    }
 
    private func retrieveFromMemory<Element>() throws -> Data where Data == Array<Element> {
        if data.isNotEmpty {
            return data
        } else {
            throw CacheError.noData
        }
    }
    
    private func retrieveFromDisk<Element: LocalStorable>() async throws -> Data where Data == Array<Element> {
        try await databaseManager.getAll()
    }
}


// MARK: Dictionary support
public extension Cache {
    func store<Element: Identifiable & LocalStorable>(_ element: Element) async throws -> Element where Data == Dictionary<Element.ID, Element> {
        switch method {
        case .inMemory:
            return storeInMemory(element)
        case .onDisk:
            return try await storeOnDisk(element)
        }
    }
    
    private func storeInMemory<Element: Identifiable>(_ element: Element) -> Element where Data == Dictionary<Element.ID, Element> {
        self.data[element.id] = element
        return element
    }
    
    private func storeOnDisk<Element: Identifiable & LocalStorable>(_ element: Element) async throws -> Element where Data == Dictionary<Element.ID, Element> {
        try await databaseManager.save(element)
    }
        
    // MARK: Get all
    func getAll<Element: Identifiable & LocalStorable>() async throws -> [Element] where Data == Dictionary<Element.ID, Element> {
        switch method {
        case .inMemory:
            try retrieveFromMemory()
        case .onDisk:
            try await retrieveFromDisk()
        }
    }
    
    private func retrieveFromMemory<Element: Identifiable>() throws -> [Element] where Data == Dictionary<Element.ID, Element> {
        if data.isNotEmpty{
            return Array(data.values)
        } else {
            throw CacheError.noData
        }
    }
    
    private func retrieveFromDisk<Element: Identifiable & LocalStorable>() async throws -> [Element] where Data == Dictionary<Element.ID, Element> {
        try await databaseManager.getAll()
    }
}
