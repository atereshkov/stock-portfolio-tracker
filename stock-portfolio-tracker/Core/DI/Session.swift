//
//  Session.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import DICE

class Session: SessionType {
    
    let container: DIContainer
    let appState: Store<AppState>
    
    init(container: DIContainer, appState: Store<AppState>) {
        self.container = container
        self.appState = appState
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
            return RootViewModel(session: self)
        }
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
        container.register { _ in
            return HomeViewModel(session: self)
        }
        container.register { _ in
            return DividendsViewModel(session: self)
        }
        container.register { _ in
            return CreatePortfolioViewModel(session: self)
        }
        container.register { _ in
            return AccountViewModel(session: self)
        }
        container.register { _ in
            return PortfolioViewModel(session: self)
        }
        container.register { _ in
            return PortfolioSettingsViewModel(session: self)
        }
    }
    
}

private extension Session {
    
    func bindService() {
        container.register(AuthServiceType.self) { _ in
            return AuthService()
        }
        container.register(AuthListenerType.self, scope: .single) { _ in
            return AuthListener(appState: self.appState)
        }
        container.register(PortfolioServiceType.self) { _ in
            return PortfolioService()
        }
    }
    
}

private extension Session {
    
    func bindRepository() {
        container.register(AuthRepositoryType.self) { _ in
            return FirebaseAuthRepository()
        }
        container.register(PortfolioRepositoryType.self) { _ in
            return FirebasePortfolioRepository(appState: self.appState)
        }
    }
    
}
