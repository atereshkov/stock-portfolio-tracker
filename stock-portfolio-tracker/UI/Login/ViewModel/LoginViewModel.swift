//
//  LoginViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import Combine

class LoginViewModel: BaseViewModel<LoginViewModelInputType, LoginViewModelOutputType>, LoginViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

extension LoginViewModel: LoginViewModelInputType {
    
    func signInAction() {
        
    }
    
}

extension LoginViewModel: LoginViewModelOutputType {
    
}
