//
//  View+Extension.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

struct AppFontModifier: ViewModifier {
    let font: JakartaSans
    let style: Font.TextStyle

    func body(content: Content) -> some View {
        content
            .font(.appFont(font, relativeTo: style))
    }
}

public extension View {
    func appFont(
        _ font: JakartaSans = .medium,
        relativeTo style: Font.TextStyle = .body
    ) -> some View {
        ModifiedContent(content: self, modifier: AppFontModifier(font: font, style: style))
    }
}
