//
//  CharacterDetailsView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import Components
import PortalGunInterface
import SwiftUI

struct CharacterDetailsView: View {
    @StateObject private var viewModel: CharacterDetailsViewModel
    @Environment(\.dismiss) var dismiss
    
    init(_ character: RMCharacter) {
        _viewModel = StateObject(wrappedValue: CharacterDetailsViewModel(character))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CharacterImageView(viewModel.character)
            
            ScrollView(showsIndicators: false) {
                CharacterStatusView(
                    viewModel.character,
                    relativeTo: .title
                )
                
                buildCharacterDetailView()
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .top, content: buildHeaderButtonsView)
        .navigationBarBackButtonHidden()
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) { }
    }

    @ViewBuilder
    private func buildHeaderButtonsView() -> some View {
        let systemName: String = viewModel.character.isFavorite ? "heart.fill" : "heart"
        
        HStack {
            StyledButtonView(systemName: "chevron.left") {
                dismiss()
            }
            
            Spacer()
            
            StyledButtonView(systemName: systemName) {
                viewModel.heartButtonIsTapped()
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func buildCharacterDetailView() -> some View {
        let character = viewModel.character
        
        VStack(alignment: .leading) {
            Divider()
            
            Text("Character Details".uppercased())
                .font(.headline)
                .fontWeight(.heavy)
            
            ParametrView("Gender:", value: character.gender)
            ParametrView("Origin:", value: character.origin?.name)
            ParametrView("Location:", value: character.location?.name)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CharacterDetailsView(.sample)
}
