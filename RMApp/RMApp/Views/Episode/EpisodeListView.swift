//
//  EpisodeListView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import Components
import PortalGunInterface
import SwiftUI

struct EpisodeListView: View {
    @StateObject private var viewModel: EpisodeViewModel
    private let rows = Array(repeating: GridItem(.fixed(75)), count: 3)
    
    init(_ character: RMCharacter) {
        _viewModel = StateObject(wrappedValue: EpisodeViewModel(character))
    }
    
    var body: some View {
        contentView
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded(let episodes):
            buildGridForEpisodes(episodes)
        case .error(let error):
            ErrorHandlerView(error, action: viewModel.fetchEpisodes)
        }
    }
    
    private func buildGridForEpisodes(_ episodes: [RMEpisode]) -> some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHGrid(rows: rows)  {
                ForEach(episodes) { episode in
                    NavigationLink {
                        EpisodeView(episode)
                    } label: {
                        EpisodeCellView(episode)
                    }
                }
            }
            .padding(.leading, 5)
        }
    }
}

#Preview {
    EpisodeListView(.sample)
}
