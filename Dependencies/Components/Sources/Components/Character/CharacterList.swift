//
//  CharacterList.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import PortalGunInterface
import SwiftUI

public struct CharacterList<Label: View>: View {
    private let characters: [RMCharacter]
    private let destination: (RMCharacter) -> Label
    
    public init(
        characters: [RMCharacter],
        destination: @escaping (RMCharacter) -> Label
    ) {
        self.characters = characters
        self.destination = destination
    }
    
    public var body: some View {
        ForEach(characters) { character in
            NavigationLink {
                destination(character)
            } label: {
                CharacterCellView(character)
            }
        }
    }
}
