//
//  LoginViewModelTests.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 1/9/21.
//

import XCTest
import SwiftUI
import DICE

@testable import stock_portfolio_tracker

class LoginViewModelTests: XCTestCase {
    
    func testViewStateShouldBeEqualToStartOnInit() {
        let state = AppState()
        let store = Store<AppState>(state)
        let container = DIContainer()
        container.register(AuthServiceType.self) { _ in
            return AuthServiceStub()
        }
        let session = Session(container: container, appState: store)
        
        let sut: LoginViewModel = session.resolve()
        
        XCTAssertEqual(sut.output.state, LoginViewState.start)
    }

}
