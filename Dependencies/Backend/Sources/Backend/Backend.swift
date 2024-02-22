//
//  BackendInterface.swift
//
//
//  Created by MaTooSens on 21/02/2024.
//

import BackendInterface
import DependencyInjection
import Foundation

public struct Dependencies {
    public static func inject() {
        Assemblies.inject(type: ClientInterface.self, object: Client())
    }
}
