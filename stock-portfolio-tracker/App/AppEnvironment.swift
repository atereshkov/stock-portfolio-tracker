//
//  AppEnvironment.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import DICE
import Firebase

struct AppEnvironment {
    let session: SessionType
    let appState: Store<AppState>
}

extension AppEnvironment {
    
    static func boot() -> AppEnvironment {
        FirebaseApp.configure()
        let container = DIContainer()
        let appState = Store<AppState>(AppState())
        let session = Session(container: container, appState: appState)
        return AppEnvironment(session: session, appState: appState)
    }
    
}
