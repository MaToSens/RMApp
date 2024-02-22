//
//  CharacterListView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import Components
import Design
import PortalGunInterface
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            showCharactersButtonView()
        case .loaded(let characters):
            buildCharacterListView(characters)
        case .error(let error):
            ErrorHandlerView(error, action: viewModel.fetchCharacters)
        }
    }
    
    private func showCharactersButtonView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
    
            StyledButtonView(title: "show characters", systemName: "eye") {
                viewModel.fetchCharacters()
            }
            .appFont(.bold)
        }
    }
    
    private func buildCharacterListView(_ characters: [RMCharacter]) -> some View {
        VStack {
            StyledButtonView(title: "hide characters", systemName: "eye.slash") {
                viewModel.removeCharacters()
            }
            .appFont(.bold)
            
            buildCharacterGridView(characters)
        }
    }
    
    private func buildCharacterGridView(_ characters: [RMCharacter]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                CharacterList(characters: characters) { character in
                    CharacterDetailsView(character: character)
                }
                
                buildLoadingIndicatorView()
            }
            .padding()
        }
    }
    
    private func buildLoadingIndicatorView() -> some View {
        LazyVStack {
            ProgressView()
                .onAppear { viewModel.fetchNextPage() }
        }
    }
}

#Preview {
    NavigationView {
        CharacterListView()
    }
}
