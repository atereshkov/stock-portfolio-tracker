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

extension LoginViewState: Equatable {
    static func == (lhs: LoginViewState, rhs: LoginViewState) -> Bool {
        switch (lhs, rhs) {
        case (.start, .start):
            return true
        case (.loading, .loading):
            return true
        case let (.loginFailed(v0), .loginFailed(v1)):
            return v0 == v1
        default:
            return false
        }
    }
}
