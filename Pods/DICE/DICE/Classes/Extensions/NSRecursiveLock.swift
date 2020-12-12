//
//  NSRecursiveLock.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

import Foundation

extension NSRecursiveLock {
    
    @discardableResult
    func sync<T>(_ block: () -> T) -> T {
        self.lock()
        defer { self.unlock() }
        return block()
    }
    
}
