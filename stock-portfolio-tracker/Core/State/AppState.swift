//
//  AppState.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var auth = AuthState()
    var user = UserData()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct UserData: Equatable {
        var id: String?
    }
}

extension AppState {
    struct AuthState: Equatable {
        var isAuthorized: Bool = false
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var auth = AuthRouting()
        var root = RootRouting()
        
        var login = LoginRouting()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.auth == rhs.auth &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.user == rhs.user
}
