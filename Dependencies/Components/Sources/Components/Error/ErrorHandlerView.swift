//
//  ErrorHandlerView.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

public struct ErrorHandlerView: View {
    private let error: Error
    private let action: () -> Void
    
    public init(
        _ error: Error,
        action: @escaping () -> Void
    ) {
        self.error = error
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Label("Error: \(error.localizedDescription)", systemImage: "exclamationmark")
            
            Button("Try again", action: action)
                .buttonStyle(.bordered)
        }
    }
}
