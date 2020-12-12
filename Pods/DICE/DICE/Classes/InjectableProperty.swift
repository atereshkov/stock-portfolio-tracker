//
//  InjectableProperty.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

import Foundation

protocol InjectableProperty {
    var key: DependencyKey { get }
    var bundle: Bundle? { get }
}

extension InjectableProperty {
    var bundle: Bundle? {
        return (key.type as? AnyClass).flatMap { Bundle(for: $0) }
    }
}
