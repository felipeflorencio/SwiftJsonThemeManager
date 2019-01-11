//
//  SwiftJsonThemeManager.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 30/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

// https://oleb.net/blog/2017/01/dictionary-key-paths/

struct KeyPath {
    var segments: [String]
    
    var isEmpty: Bool { return segments.isEmpty }
    var path: String {
        return segments.joined(separator: ".")
    }
    
    /// Strips off the first segment and returns a pair
    /// consisting of the first segment and the remaining key path.
    /// Returns nil if the key path has no segments.
    func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
}

/// Initializes a KeyPath with a string of the form "this.is.a.keypath"
extension KeyPath: ExpressibleByStringLiteral {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
    
    init(stringLiteral value: String) {
        self.init(value)
    }
    init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

protocol StringProtocol {
    init(string s: String)
}

extension String: StringProtocol {
    init(string s: String) {
        self = s
    }
}

extension Dictionary where Key: StringProtocol {
    subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return nil
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = Key(string: head)
                return self[key]
            case let (head, remainingKeyPath)?:
                // Key path has a tail we need to traverse.
                let key = Key(string: head)
                switch self[key] {
                case let nestedDict as [Key: Any]:
                    // Next nest level is a dictionary.
                    // Start over with remaining key path.
                    return nestedDict[keyPath: remainingKeyPath]
                default:
                    // Next nest level isn't a dictionary.
                    // Invalid key path, abort.
                    return nil
                }
            }
        }
        set {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = Key(string: head)
                self[key] = newValue as? Value
            case let (head, remainingKeyPath)?:
                let key = Key(string: head)
                let value = self[key]
                switch value {
                case var nestedDict as [Key: Any]:
                    // Key path has a tail we need to traverse
                    nestedDict[keyPath: remainingKeyPath] = newValue
                    self[key] = nestedDict as? Value
                default:
                    // Invalid keyPath
                    return
                }
            }
        }
    }
    
    subscript(string keyPath: String) -> String? {
        get { return self[keyPath: KeyPath(keyPath)] as? String }
        set { self[keyPath: KeyPath(keyPath)] = newValue }
    }
    
    subscript(arrayString keyPath: String) -> [String]? {
        get { return self[keyPath: KeyPath(keyPath)] as? [String] }
        set { self[keyPath: KeyPath(keyPath)] = newValue }
    }
    
    subscript(dict keyPath: String) -> [Key: Any]? {
        get { return self[keyPath: KeyPath(keyPath)] as? [Key: Any] }
        set { self[keyPath: KeyPath(keyPath)] = newValue }
    }
    
    subscript(array keyPath: String) -> [Any]? {
        get { return self[keyPath: KeyPath(keyPath)] as? [Any] }
        set { self[keyPath: KeyPath(keyPath)] = newValue }
    }
}
