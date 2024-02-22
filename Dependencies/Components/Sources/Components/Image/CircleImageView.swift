//
//  File.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

public struct CircleImageView: View {
    private let systemName: String
    
    public init(_ systemName: String) {
        self.systemName = systemName
    }
    
    public var body: some View {
        Image(systemName: "eye")
            .font(.headline)
            .padding(10)
            .background(
                Circle()
                    .fill(.white)
                    .shadow(radius: 1)
            )
    }
}
