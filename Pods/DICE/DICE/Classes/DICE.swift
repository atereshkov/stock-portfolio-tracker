//
//  DICE.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

import Foundation

public struct DICE {
    
    internal private(set) static var sharedContainer: DIContainer = DIContainer()
    
}

// MARK: API

public extension DICE {
    
    enum Defaults {
        /// Set default lifetime for container instances. `DIScope.objectGraph` is set by default.
        public static var scope: DIScope = .objectGraph
    }
    
    /// When container is set for usage then dependencies can be resolved through environment variables `Injected`, `EnvironmentObservableInjected` and `EnvironmentInjected`
    static func use(_ container: DIContainer) {
        self.sharedContainer = container
    }
    
}
