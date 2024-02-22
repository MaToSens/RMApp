//
//  FavoriteView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import Components
import PortalGunInterface
import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
   
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let characters):
                buildFavoriteView(characters)
            case .error(let error):
                ErrorHandlerView(error) {
                    viewModel.fetchFavouriteCharacters()
                }
            }
        }
        .onAppear {
            viewModel.fetchFavouriteCharacters()
        }
    }
    
    private func buildFavoriteView(_ characters: [RMCharacter]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                CharacterList(characters: characters) { character in
                    CharacterDetailsView(character)
                }
            }
            .padding()
        }
    }
}

#Preview {
    FavoriteView()
}
