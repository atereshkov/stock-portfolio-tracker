//
//  AuthListenerService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import DICE
import FirebaseAuth

protocol AuthListenerType {
    
}

class AuthListener: AuthListenerType {
    
    let appState: Store<AppState>
    
    @Injected var authRepository: AuthRepositoryType
    
    init(appState: Store<AppState>) {
        self.appState = appState
        
        listenAuthChanges()
    }
    
}

private extension AuthListener {
    
    private func listenAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Swift.print("[TEST] Listener auth user: \(String(describing: user))")
            self?.appState[\.userData.isAuthorized] = user != nil
        }
    }
    
}
