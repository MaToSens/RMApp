//
//  Database.swift
//
//
//  Created by MaTooSens on 21/02/2024.
//

import DatabaseInterface
import DependencyInjection

public struct Dependencies {
    public static func inject() {
        Assemblies.inject(type: FileStorageManagerInterface.self, object: FileStorageManager())
    }
}
