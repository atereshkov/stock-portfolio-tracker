//
//  Session.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import DICE

class Session: SessionType {
    
    private(set) var container: DIContainer = DIContainer()
    
    init() {
        bind()
    }
    
    func resolve<T>() -> T {
        return container.resolve()
    }
    
}

private extension Session {
    
    func bind() {
        bindViewModel()
        
        DICE.use(container)
    }
    
    func bindViewModel() {
        container.register { _ in
            return ContentViewModel(session: self)
        }
    }
    
}
