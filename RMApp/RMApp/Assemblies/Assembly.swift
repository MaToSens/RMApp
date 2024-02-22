//
//  Assembly.swift
//  RMApp
//
//  Created by MaTooSens on 21/02/2024.
//

import PortalGun
import DependencyInjection

extension Assemblies {
    static func setupDependencies() {
        PortalGun.Dependencies.inject()
    }
}
