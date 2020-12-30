//
//  FirebaseAuthRepository.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/30/20.
//

import FirebaseAuth

class FirebaseAuthRepository: AuthRepositoryType {
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            Swift.print(authResult)
            Swift.print(error)
        }
    }
    
}
