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
        bindService()
        bindRepository()
        
        DICE.use(container)
    }
    
}

private extension Session {
    
    func bindViewModel() {
        container.register { _ in
            return MainViewModel(session: self)
        }
        container.register { _ in
            return WelcomeViewModel(session: self)
        }
        container.register { _ in
            return LoginViewModel(session: self)
        }
        container.register { _ in
            return SignUpViewModel(session: self)
        }
    }
    
}

private extension Session {
    
    func bindService() {
        container.register(AuthServiceType.self) { _ in
            return AuthService()
        }
    }
    
}

private extension Session {
    
    func bindRepository() {
        container.register(AuthRepositoryType.self) { _ in
            return FirebaseAuthRepository()
        }
    }
    
}
