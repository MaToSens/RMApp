//
//  Cacheable.swift
//
//
//  Created by MaTooSens on 22/02/2024.
//

import Foundation

public protocol Cacheable {
    var isNotEmpty: Bool { get }
    static var empty: Self { get }
    mutating func invalidate()
}

extension Array: Cacheable {
    public var isNotEmpty: Bool { !isEmpty }
    public static var empty: [Element] { [] }
    public mutating func invalidate() { removeAll() }
}

extension Dictionary: Cacheable {
    public var isNotEmpty: Bool { !isEmpty }
    public static var empty: Dictionary<Key, Value> { [:] }
    public mutating func invalidate() { removeAll() }
}

public enum CacheError: Error {
    case noData
}
