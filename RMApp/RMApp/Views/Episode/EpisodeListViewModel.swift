//
//  EpisodeListViewModel.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import PortalGunInterface
import DependencyInjection
import Foundation

@MainActor
final class EpisodeViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([RMEpisode])
        case error(Error)
    }
    
    @Inject private var portalGunManager: PortalGunManagerInterface
    
    @Published private(set) var state: State = .loading
    private let character: RMCharacter
    
    init(_ character: RMCharacter) {
        self.character = character
        fetchEpisodes()
    }
    
    func fetchEpisodes() {
        Task {
            do {
                let episodes = try await portalGunManager.fetchEpisodes(character)
                self.state = .loaded(episodes)
            } catch {
                self.state = .error(error)
            }
        }
    }
}
