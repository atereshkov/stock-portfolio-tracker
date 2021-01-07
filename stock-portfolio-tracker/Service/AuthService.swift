//
//  AuthService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/30/20.
//

import DICE
import Combine

protocol AuthServiceType {
    
    func createUser(email: String, password: String) -> Future<Void, Error>
    
    func signIn(email: String, password: String) -> Future<Void, Error>
    
    func logout()
    
}

class AuthService: AuthServiceType {
    
    @Injected var authRepository: AuthRepositoryType
    
}

extension AuthService {
    
    func createUser(email: String, password: String) -> Future<Void, Error> {
        return authRepository.createUser(email: email, password: password)
    }
    
    func signIn(email: String, password: String) -> Future<Void, Error> {
        return authRepository.signIn(email: email, password: password)
    }
    
    func logout() {
        authRepository.logout()
    }
    
}
