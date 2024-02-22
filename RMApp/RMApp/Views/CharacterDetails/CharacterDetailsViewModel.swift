//
//  CharacterDetailsViewModel.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import DependencyInjection
import Foundation
import PortalGunInterface

@MainActor
final class CharacterDetailsViewModel: ObservableObject {
    
    @Inject private var portalGunManager: PortalGunManagerInterface
    @Published private(set) var character: RMCharacter
    @Published private(set) var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    init(_ character: RMCharacter) {
        self.character = character
    }
    
    func heartButtonIsTapped() {
        Task {
            do {
                self.character = try await portalGunManager.updateFavoriteStatus(for: character)
            } catch {
                self.showAlert = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
