//
//  CharacterStatusView.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import Design
import PortalGunInterface
import SwiftUI

public struct CharacterStatusView: View {
    private let character: RMCharacter
    private let relativeTo: Font.TextStyle
    
    public init(
        _ character: RMCharacter,
        relativeTo: Font.TextStyle
    ) {
        self.character = character
        self.relativeTo = relativeTo
    }
    
    public var body: some View {
        HStack {
            Circle()
                .fill(character.status.color)
                .frame(width: 15)
            
            Text(character.name.uppercased())
                .appFont(.semibold, relativeTo: relativeTo)
                .foregroundColor(.black)
                .lineLimit(1)
        }
    }
}


