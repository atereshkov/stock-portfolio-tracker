//
//  stock_portfolio_trackerApp.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import SwiftUI
import Firebase

@main
struct SPTApp: App {
    
    private let session = Session()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
