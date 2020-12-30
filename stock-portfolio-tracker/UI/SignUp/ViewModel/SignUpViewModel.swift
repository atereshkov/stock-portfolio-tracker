//
//  SignUpViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import Combine

class SignUpViewModel: BaseViewModel<SignUpViewModelInputType, SignUpViewModelOutputType>, SignUpViewModelType {
    
    private let authService: AuthServiceType
    
    override init(session: SessionType) {
        self.authService = session.resolve()
        super.init(session: session)
    }
    
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    
}

// MARK: - SignUpViewModelInputType

extension SignUpViewModel: SignUpViewModelInputType {
    
    func viewDidLoad() {
        
    }
    
    func signUpAction() {
        guard let email = email?.trim(), let pw = password?.trim() else { return }
        authService.createUser(email: email, password: pw)
    }
    
}

// MARK: - SignUpViewModelOutputType

extension SignUpViewModel: SignUpViewModelOutputType {
    
}
