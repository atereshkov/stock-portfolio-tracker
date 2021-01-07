//
//  SignUpViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import Combine
import SwiftUI

class SignUpViewModel: BaseViewModel<SignUpViewModelInputType, SignUpViewModelOutputType>, SignUpViewModelType {
    
    private let authService: AuthServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.authService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.signUp)
        
        super.init(session: session)
    }
    
    // MARK: - Input
    
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    
    // MARK: - Output
    
    @Published var state: SignUpViewState = .start
    @Published var routingState: SignUpRouting
    
}

// MARK: - SignUpViewModelInputType

extension SignUpViewModel: SignUpViewModelInputType {
    
    func signUpAction() {
        guard let email = email?.trim(), let pw = password?.trim() else { return }
        guard !email.isEmpty, !pw.isEmpty else { return }
        
        state = .loading
        
        authService
            .createUser(email: email, password: pw)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .signUpFailed(error: error.localizedDescription)
                    self?.routingState.showErrorAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)
    }
    
}

// MARK: - SignUpViewModelOutputType

extension SignUpViewModel: SignUpViewModelOutputType {
    
}
