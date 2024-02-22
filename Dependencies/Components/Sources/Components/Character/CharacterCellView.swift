//
//  SwiftUIView.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import Design
import PortalGunInterface
import SwiftUI

struct CharacterCellView: View {
    private let character: RMCharacter
    
    init(_ character: RMCharacter) {
        self.character = character
    }
    
    var body: some View {
        VStack {
            buildCharacteImageView()
            
            CharacterStatusView(character, relativeTo: .footnote)
        }
        .padding(.vertical, 10)
    }
    
    private func buildCharacteImageView() -> some View {
        ZStack(alignment: .topTrailing) {
            CharacterImageView(character)
                .cornerRadius(20)
                .overlay(
                     RoundedRectangle(cornerRadius: 20)
                         .stroke(.white, lineWidth: 2)
                         .shadow(radius: 1)
                 )
            
            if character.isFavorite {
                CircleImageView("heart.fill")
                    .padding()
            }
        }
     
    }
}
