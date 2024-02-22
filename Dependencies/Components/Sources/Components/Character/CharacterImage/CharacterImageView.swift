//
//  SwiftUIView.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import PortalGunInterface
import SwiftUI

public struct CharacterImageView: View {
    @StateObject private var viewModel: CharacterImageViewModel
    
    public init(_ character: RMCharacter) {
        _viewModel = StateObject(wrappedValue: CharacterImageViewModel(character))
    }
    
    public var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        case .error:
            Image(systemName: "questionmark")
        }
    }
}
