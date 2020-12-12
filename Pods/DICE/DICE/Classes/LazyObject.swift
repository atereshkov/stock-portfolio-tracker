//
//  Lazy.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

class LazyObject {
    
    var initBlock: (DIContainer) -> Any
    var container: DIContainer
    
    init(initBlock: @escaping (DIContainer) -> Any, container: DIContainer) {
        self.initBlock = initBlock
        self.container = container
    }
    
}

// MARK: Public

extension LazyObject {
    
    func resolve<T>() -> T {
        return self.initBlock(container) as! T
    }
    
}
