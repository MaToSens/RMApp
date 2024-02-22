//
//  PortalGun.swift
//
//
//  Created by MaTooSens on 21/02/2024.
//

import Backend
import Database
import DependencyInjection
import Foundation
import PortalGunInterface

public struct Dependencies {
    public static func inject() {
        Backend.Dependencies.inject()
        Database.Dependencies.inject()
        
        Assemblies.inject(type: PortalGunManagerInterface.self, object: PortalGunManager())
        Assemblies.inject(type: CharactersDataProviderInterface.self, object: CharactersDataProvider())
        Assemblies.inject(type: CharacterImageDataProviderInterface.self, object: CharacterImageDataProvider())
    }
}
