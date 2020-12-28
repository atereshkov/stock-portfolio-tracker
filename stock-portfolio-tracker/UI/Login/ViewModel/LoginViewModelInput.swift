//
//  LoginViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/25/20.
//

import SwiftUI

protocol LoginViewModelInputType {
    func signInAction()
    
    var email: String { get }
    var password: String { get }
}
