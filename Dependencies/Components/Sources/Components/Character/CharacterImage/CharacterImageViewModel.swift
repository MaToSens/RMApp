//
//  CharacterImageViewModel.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import DependencyInjection
import PortalGunInterface
import SwiftUI


final class CharacterImageViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(UIImage)
        case error(Error)
    }
    
    @Inject private var portalGunManager: PortalGunManagerInterface
    
    @Published private(set) var state: State = .loading
    private let character: RMCharacter
    
    init(_ character: RMCharacter) {
        self.character = character
        getImage()
    }
    
    func getImage() {
        Task {
            do {
                let uiImage = try await portalGunManager.fetchCharacterImage(for: character)
                DispatchQueue.main.async { self.state = .loaded(uiImage) }
            } catch {
                self.state = .error(error)
            }
        }
    }
}

