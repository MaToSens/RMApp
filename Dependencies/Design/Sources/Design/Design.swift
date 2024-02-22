//
//  Font+Extension.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import SwiftUI

public struct AppFont {
    public static func registerFonts() {
        JakartaSans
            .allCases
            .forEach {
                registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
            }
    }
    
    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard
            let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let font = CGFont(fontDataProvider)
        else {
            fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
