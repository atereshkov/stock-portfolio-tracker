//
//  LoginViewState.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import Foundation

enum LoginViewState {
    case start
    case loading
    case loginFailed(error: String)
}
