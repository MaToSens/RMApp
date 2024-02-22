//
//  CharacterListViewModel.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import DependencyInjection
import Foundation
import PortalGunInterface

@MainActor
final class CharacterListViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([RMCharacter])
        case error(Error)
    }
    
    @Inject private var portalGunManager: PortalGunManagerInterface
    
    @Published private(set) var state: State = .loading
    @Published private(set) var page: Int = 1
    
    func fetchCharacters() {
        Task {
            do {
                let newCharacters = try await portalGunManager.fetchCharacters(page: page)
                updateState(with: newCharacters)
            } catch {
                self.state = .error(error)
            }
        }
    }
    
    func fetchNextPage() {
        self.page += 1
        fetchCharacters()
    }
    
    func removeCharacters() {
        if case .loaded = state { self.state = .loading }
    }
    
    private func updateState(with newCharacters: [RMCharacter]) {
        switch state {
        case .loaded(let existingCharacters):
            self.state = .loaded(existingCharacters + newCharacters)
        default:
            self.state = .loaded(newCharacters)
        }
    }
}
