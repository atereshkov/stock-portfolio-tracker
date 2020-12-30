//
//  SignUpViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import Combine

class SignUpViewModel: BaseViewModel<SignUpViewModelInputType, SignUpViewModelOutputType>, SignUpViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
}

// MARK: - SignUpViewModelInputType

extension SignUpViewModel: SignUpViewModelInputType {
    
    func viewDidLoad() {
        
    }
    
    func signUpAction() {
        
    }
    
}

// MARK: - SignUpViewModelOutputType

extension SignUpViewModel: SignUpViewModelOutputType {
    
}
