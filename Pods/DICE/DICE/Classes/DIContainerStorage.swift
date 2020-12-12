//
//  DIContainerStorage.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

import Foundation

class DIContainerStorage {
    
    let locker = NSRecursiveLock()
    
    lazy var storedObjects: [DependencyKey: DIObject] = [:]
    
    func insert<T>(_ object: DIObject, forType type: T.Type) {
        locker.sync { self.storedObjects[object.key] = object }
    }
    
    var objects: [DIObject] {
        return locker.sync { self.storedObjects.values.compactMap { $0 } }
    }
    
}

extension DIContainerStorage {
    
    subscript(_ key: DependencyKey) -> DIObject? {
        return locker.sync { self.storedObjects[key] }
    }
    
}
