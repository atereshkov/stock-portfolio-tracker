//
//  AuthRepositoryType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/30/20.
//

import Foundation
import Combine

protocol AuthRepositoryType {
    
    func createUser(email: String, password: String) -> Future<Void, Error>
    
    func signIn(email: String, password: String) -> Future<Void, Error>
    
    func logout()
}
