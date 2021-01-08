//
//  RootViewModelTests.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 1/8/21.
//

import XCTest
import SwiftUI
@testable import stock_portfolio_tracker

class RootViewModelTests: XCTestCase {
    
    private var defaultSesssion: SessionType {
        let state = AppState()
        let store = Store<AppState>(state)
        let session = Session(appState: store)
        return session
    }
    
    func testWhenAuthorizedStateIsFalseViewModelShouldReturnFalse() {
        let session = defaultSesssion
        session.appState[\.auth.isAuthorized] = false
        
        let appViewModel: RootViewModel = session.resolve()
        
        _ = appViewModel.$isAuthorized.sink { isAuthorized in
            XCTAssertFalse(isAuthorized)
        }
    }
    
    func testWhenAuthorizedStateIsTrueViewModelShouldReturnTrue() {
        let session = defaultSesssion
        session.appState[\.auth.isAuthorized] = true
        
        let appViewModel: RootViewModel = session.resolve()
        
        _ = appViewModel.$isAuthorized.sink { isAuthorized in
            XCTAssertTrue(isAuthorized)
        }
    }

}
