//
//  Font+Extension.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

public enum JakartaSans: String, CaseIterable {
    case medium = "PlusJakartaSans-Medium"
    case semibold = "PlusJakartaSans-SemiBold"
    case bold    = "PlusJakartaSans-Bold"
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle:   return 34
        case .title:        return 28
        case .title2:       return 22
        case .title3:       return 20
        case .headline:     return 17
        case .subheadline:  return 17
        case .body:         return 16
        case .callout:      return 15
        case .footnote:     return 13
        case .caption:      return 12
        case .caption2:     return 11
        @unknown default:   return 8
        }
    }
}

extension Font {
    static func appFont(_ font: JakartaSans, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }
}
