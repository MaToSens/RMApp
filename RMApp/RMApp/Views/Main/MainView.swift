//
//  MainView.swift
//  RMApp
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
    }
    
    var body: some View {
        NavigationView {
            TabView {
                CharacterListView()
                    .tabItem { Label("Characters", systemImage: "square.grid.2x2.fill") }
                
                // FavoriteView
            }
        }
    }
}

#Preview {
    MainView()
}
