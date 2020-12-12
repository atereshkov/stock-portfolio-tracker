//
//  DIContainerBuilder.swift
//  DICE
//
//  Created by Alexander Tereshkov on 9/6/20.
//

import Foundation

public class DIContainerBuilder<T> {
    
    private var manager: DIContainerStorage
    private var object: DIObject
    
    init(container: DIContainer, object: DIObject) {
        self.object = object
        self.manager = container.containerStorage
        self.manager.insert(object, forType: T.self)
    }
    
}
