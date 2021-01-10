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
        bindListeners()
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
        container.register { _ in
            return FeesViewModel(session: self)
        }
        container.register { _ in
            return TransactionsViewModel(session: self)
        }
        container.register { _ in
            return DividendsViewModel(session: self)
        }
        container.register { _ in
            return DividendViewModel(session: self)
        }
        container.register { _ in
            return AddDividendViewModel(session: self)
        }
    }
    
}

private extension Session {
    
    func bindService() {
        container.register(AuthServiceType.self) { _ in
            return AuthService()
        }
        container.register(PortfolioServiceType.self) { _ in
            return PortfolioService()
        }
        container.register(DividendServiceType.self) { _ in
            return DividendService()
        }
    }
    
}

private extension Session {
    
    func bindListeners() {
        container.register(AuthListenerType.self, scope: .single) { _ in
            return AuthListener(appState: self.appState)
        }
        container.register(PortfolioListenerType.self, scope: .single) { _ in
            return PortfolioListener(session: self)
        }
        container.register(DividendListenerType.self, scope: .single) { _ in
            return DividendListener(session: self)
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
        container.register(DividendRepositoryType.self) { _ in
            return FirebaseDividendRepository(appState: self.appState)
        }
    }
    
}
