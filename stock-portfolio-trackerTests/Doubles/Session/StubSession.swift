//
//  StubSession.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 1/8/21.
//

import XCTest
import SwiftUI
import DICE
@testable import stock_portfolio_tracker

class StubSession: SessionType {
    
    let container = DIContainer()
    let appState: Store<AppState>
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
    func resolve<T>() -> T {
        return container.resolve()
    }
    
}
