//
//  ParametrView.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import Design
import SwiftUI

public struct ParametrView: View {
    private let title: String
    private let value: String?
    
    public init(
        _ title: String,
        value: String?
    ) {
        self.title = title
        self.value = value
    }
    
    public var body: some View {
        HStack {
            Text(title.capitalized)
                .appFont(.bold)
            
            Text(value ?? "N/A")
        }
    }
}
