//
//  DependencyKey.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/9/20.
//  Copyright © 2020 DICE. All rights reserved.
//

public struct DependencyKey: Hashable, Equatable {
    
    public let type: Any.Type
    public let tag: String?
    
    public init(type: Any.Type, tag: String? = "") {
        self.type = type
        self.tag = tag
    }
    
}

extension DependencyKey {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(tag)
    }

    public static func ==(lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        return lhs.type == rhs.type && lhs.tag == rhs.tag
    }
    
}
