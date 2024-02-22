//
//  FavoriteViewModel.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import DependencyInjection
import PortalGunInterface
import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([RMCharacter])
        case error(Error)
    }
        
    @Inject private var portalGunManager: PortalGunManagerInterface
    @Published private(set) var state: State = .loading
    
    func fetchFavouriteCharacters() {
        Task {
            do {
                let favoriteCharacters = try await portalGunManager.fetchFavoriteCharacter()
                self.state = .loaded(favoriteCharacters)
            } catch {
                self.state = .error(error)
            }
        }
    }
}
