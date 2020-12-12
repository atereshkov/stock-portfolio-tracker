//
//  EnvironmentInjected.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/7/20.
//  Copyright © 2020 DICE. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)

import SwiftUI
import Combine

/// Property wrapper that inject object from environment container. Read only object. Typically used for non-mutating objects.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper
public struct EnvironmentInjected<Value: AnyObject>: DynamicProperty {
    
    private var tag: String? = ""
    
    public let wrappedValue: Value
    
    public init() {
        let bundle = Bundle(for: Value.self)
        let resolvedValue = Environment(\.container).wrappedValue.resolve(tag: tag, bundle: bundle) as Value
        self.wrappedValue = resolvedValue
    }
    
    public init(_ tag: String? = "") {
        let bundle = Bundle(for: Value.self)
        let resolvedValue = Environment(\.container).wrappedValue.resolve(tag: tag, bundle: bundle) as Value
        self.wrappedValue = resolvedValue
        self.tag = tag
    }
}

@available(iOS 13.0, *)
extension EnvironmentInjected: InjectableProperty {
    var key: DependencyKey {
        return DependencyKey(type: Value.self, tag: tag)
    }
}

#endif
