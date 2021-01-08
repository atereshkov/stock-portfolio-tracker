//
//  LoginViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import Combine
import SwiftUI

class LoginViewModel: BaseViewModel<LoginViewModelInputType, LoginViewModelOutputType>, LoginViewModelType {
    
    private let authService: AuthServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.authService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.login)
        
        super.init(session: session)
        
        bindRouting(session: session)
    }
    
    // MARK: - Input
    
    @Published var email: String?
    @Published var password: String?
    
    // MARK: - Output
    
    @Published var state: LoginViewState = .start
    @Published var routingState: LoginRouting
    
}

extension LoginViewModel: LoginViewModelInputType {
    
    func signInAction() {
        guard let email = email?.trim(), let pw = password?.trim() else { return }
        guard !email.isEmpty, !pw.isEmpty else { return }
        
        state = .loading
        
        authService
            .signIn(email: email, password: pw)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .loginFailed(error: error.localizedDescription)
                    self?.routingState.showErrorAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)
    }
    
}

extension LoginViewModel: LoginViewModelOutputType {
    
}

private extension LoginViewModel {
    
    private func bindRouting(session: SessionType) {
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.login] = $0 }
            session.appState.map(\.routing.login)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
    }
    
}
