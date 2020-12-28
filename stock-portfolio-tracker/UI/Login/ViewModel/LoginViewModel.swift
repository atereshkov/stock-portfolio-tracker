//
//  LoginViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import Combine
import SwiftUI

class LoginViewModel: BaseViewModel<LoginViewModelInputType, LoginViewModelOutputType>, LoginViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
    @Published var email = ""
    @Published var password = ""
    
}

extension LoginViewModel: LoginViewModelInputType {
    
    func signInAction() {
        
    }
    
}

extension LoginViewModel: LoginViewModelOutputType {
    
}
