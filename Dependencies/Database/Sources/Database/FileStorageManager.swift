//
//  FileStorageManager.swift
//  
//
//  Created by MaTooSens on 21/02/2024.
//

import DatabaseInterface
import Foundation

final class FileStorageManager: FileStorageManagerInterface {
    private let fileManager = FileManager.default
    
    func save(
        data: Data,
        folderName: String,
        fileName: String,
        withExtension fileExtension: String
    ) throws {
        try createFolderIfNeeded(folderName)
        
        let fileURL = try urlForData(
            folderName: folderName,
            fileName: fileName,
            withExtension: fileExtension
        )
        
        print("Save - fileURL: ", fileURL)
        do {
            try data.write(to: fileURL)
        } catch {
            throw FileStorageManagerError.unableToSave
        }
    }
    
    func retrieve(
        folderName: String,
        fileName: String,
        withExtension fileExtension: String
    ) throws -> Data {
        let fileURL = try urlForData(
            folderName: folderName,
            fileName: fileName,
            withExtension: fileExtension
        )
    
        guard fileManager.fileExists(atPath: fileURL.path) else {
            throw FileStorageManagerError.unableToFind
        }
        
        return try Data(contentsOf: fileURL)
    }
}

// MARK: Helper Functions
private extension FileStorageManager {
    func createFolderIfNeeded(_ folderName: String) throws {
        let folderPath = try urlForFolder(folderName).path
        
        guard !fileManager.fileExists(atPath: folderPath) else { return }
        
        do {
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true)
        } catch {
            throw FileStorageManagerError.unableToCreateDirectory
        }
    }
    
    func urlForData(
        folderName: String,
        fileName: String,
        withExtension fileExtension: String
    ) throws -> URL {
        try urlForFolder(folderName).appendingPathComponent(fileName + fileExtension)
    }
    
    func urlForFolder(_ folderName: String) throws -> URL {
        guard let url = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first else {
            throw FileStorageManagerError.unableToAccessURL
        }
        
        return url.appendingPathComponent(folderName)
    }
}

