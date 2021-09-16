//
//  stock_portfolio_trackerApp.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/12/20.
//

import SwiftUI
import DICE

@main
struct SPTApp: App {
    
    let environment = AppEnvironment.boot()
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
