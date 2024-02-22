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
            
            buildCharacterDetails()
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
    
    private func buildCharacterDetails() -> some View {
        HStack  {
            Circle()
                .foregroundColor(character.status.color)
                .frame(width: 15, height: 15)
            
            Text(character.name)
                .foregroundColor(.black)
                .appFont(.semibold, relativeTo: .footnote)
                .lineLimit(1)
        }
    }
}
