//
//  AssemblyShared.swift
//  RMApp
//
//  Created by MaTooSens on 21/02/2024.
//

import DependencyInjection
import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        Assemblies.setupDependencies()
        AssemblyShared.setupDependnecies()
    }
}

final class AssemblyShared {
    static func setupDependnecies() {
        // Inject here
    }
}
