//
//  AppTests.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 1/8/21.
//

import XCTest
import SwiftUI
@testable import stock_portfolio_tracker

class AppTests: XCTestCase {
    
    private var defaultSesssion: SessionType {
        let state = AppState()
        let store = Store<AppState>(state)
        let session = Session(appState: store)
        return session
    }
    
    func test() {
        
    }

}
