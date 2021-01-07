//
//  LoginViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import Combine
import SwiftUI

class LoginViewModel: BaseViewModel<LoginViewModelInputType, LoginViewModelOutputType>, LoginViewModelType {
    
    @Published var routingState: LoginRouting
    
    private let authService: AuthServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.authService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.login)
        
        super.init(session: session)
    }
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var state: LoginViewState = .start
    
}

extension LoginViewModel: LoginViewModelInputType {
    
    func signInAction() {
        state = .loading
        
        authService
            .signIn(email: email, password: password)
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
