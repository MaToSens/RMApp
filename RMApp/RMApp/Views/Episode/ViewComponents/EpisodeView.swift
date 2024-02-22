//
//  EpisodeView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import Components
import PortalGunInterface
import SwiftUI

struct EpisodeView: View {
    private let episode: RMEpisode
    
    init(_ episode: RMEpisode) {
        self.episode = episode
    }
    
    var body: some View {
        VStack {
            ParametrView("Name:", value: episode.name)
            ParametrView("Air Date:", value: episode.airDate)
            ParametrView("Episode:", value: episode.episode)
            
            Text("Number of characters appearing in the episode: \(episode.characters.count)")
        }
        .navigationTitle(episode.name)
    }
}

#Preview {
    EpisodeView(.sample)
}
