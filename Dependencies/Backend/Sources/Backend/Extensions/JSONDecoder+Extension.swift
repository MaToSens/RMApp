//
//  JSONDecoder+Extension.swift
//  
//
//  Created by MaTooSens on 22/02/2024.
//

import Foundation

public extension JSONDecoder {
    convenience init(
        withKeyDecodingStrategy keyDecodingStrategy: KeyDecodingStrategy
    ) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
