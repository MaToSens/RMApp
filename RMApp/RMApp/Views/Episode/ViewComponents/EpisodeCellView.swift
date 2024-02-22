//
//  EpisodeCellView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import Design
import PortalGunInterface
import SwiftUI

struct EpisodeCellView: View{
    private let episode: RMEpisode
    
    init(_ episode: RMEpisode) {
        self.episode = episode
    }
    
    var body: some View {
        VStack {
            Image(systemName: "play.tv.fill")
            
            Text(episode.episode)
        }
        .appFont(.semibold)
        .padding()
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 1)
        )
    }
}
#Preview {
    EpisodeCellView(.sample)
}
