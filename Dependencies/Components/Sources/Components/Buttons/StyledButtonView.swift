//
//  StyledButtonView.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

public struct StyledButtonView<Label: View> : View {
    private let action: () -> Void
    private let label: Label
    
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
        Button(action: action) {
            label
        }
        .foregroundColor(.black)
    }
}

public extension StyledButtonView where Label == CircleImageView {
    init(
        systemName: String,
        action: @escaping () -> Void
    ) {
        self.init(
            action: action,
            label: { CircleImageView(systemName) }
        )
    }
}

public extension StyledButtonView where Label == TupleView<(Text, CircleImageView)> {
    init(
        title: String,
        systemName: String,
        action: @escaping () -> Void
    ) {
        self.init(
            action: action,
            label: {
                Text(title.uppercased())
                
                CircleImageView(systemName)
            }
        )
    }
}
