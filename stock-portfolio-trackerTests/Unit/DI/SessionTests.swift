//
//  stock_portfolio_trackerTests.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 12/12/20.
//

import XCTest
@testable import stock_portfolio_tracker

// swiftlint:disable redundant_discardable_let
class SessionTests: XCTestCase {
    
    func testViewModelShouldBeRegistered() {
        let appState = Store<AppState>(AppState())
        let session = Session(appState: appState)
        
        let _ : MainViewModel = session.resolve()
        let _ : WelcomeViewModel = session.resolve()
        let _ : LoginViewModel = session.resolve()
        let _ : SignUpViewModel = session.resolve()
    }

}
// swiftlint:enable redundant_discardable_let
