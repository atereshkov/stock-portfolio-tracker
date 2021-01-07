//
//  AuthService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/30/20.
//

import DICE

protocol AuthServiceType {
    
    func createUser(email: String, password: String)
    
    func logout()
    
}

class AuthService: AuthServiceType {
    
    @Injected var authRepository: AuthRepositoryType
    
}

extension AuthService {
    
    func createUser(email: String, password: String) {
        authRepository.createUser(email: email, password: password)
    }
    
    func logout() {
        authRepository.logout()
    }
    
}
