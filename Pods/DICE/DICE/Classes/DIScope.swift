//
//  DIScope.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/7/20.
//  Copyright © 2020 DICE. All rights reserved.
//

public enum DIScope {
    /// Dependency is created per container as single instance.
    /// Recommended to use `DIScope.single` for singletones that should be instantiated as soon as injected in the `DIContainer`.
    case single
    
    /// Dependency is lazily created one per container, but destory when dependency object will deinit.
    /// Object will be instantiated only after first call.
    case weak
    
    /// Dependency instance is lazily created each time.
    /// Object will be instantiated only after first call.
    case prototype
    
    /// Dependency instance is lazily created one per object graph.
    /// Object will be instantiated only after first call.
    case objectGraph
}

extension DIScope: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
            case .single:
                return "single"
            case .weak:
                return "weak"
            case .prototype:
                return "prototype"
            case .objectGraph:
                return "objectGraph"
        }
    }
    
}
