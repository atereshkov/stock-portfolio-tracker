//
//  Inject.swift
//  DICE
//
//  Created by Alexander Tereshkov on 6/27/20.
//  Copyright © 2020 DICE. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Injected<Value> {
    
    typealias LazyInject = () -> Value
    
    private let tag: String?
    private var _value: Value?
    private var lazy: LazyInject?
    
    public var wrappedValue: Value {
        mutating get {
            if let value = _value {
                return value
            } else if let lazy = self.lazy {
                self._value = lazy()
                return _value!
            } else {
                fatalError("Bad init")
            }
        }
    }

    public init(_ tag: String? = "") {
        let bundle = (Value.self as? AnyClass).flatMap { Bundle(for: $0) }
        let lazy: LazyInject = { DICE.sharedContainer.resolve(tag: tag, bundle: bundle) }
        self.lazy = lazy
        self.tag = tag
    }
    
}

extension Injected: InjectableProperty {
    var key: DependencyKey {
        return DependencyKey(type: Value.self, tag: tag)
    }
}
