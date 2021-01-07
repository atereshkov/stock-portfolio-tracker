//
//  SignUpViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/29/20.
//

import Foundation

protocol SignUpViewModelInputType {    
    func signUpAction()
    
    var email: String? { get }
    var password: String? { get }
    var confirmPassword: String? { get }
}
