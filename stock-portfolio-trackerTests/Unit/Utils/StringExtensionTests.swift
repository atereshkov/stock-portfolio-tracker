//
//  StringExtensionTests.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 1/8/21.
//

import XCTest
import SwiftUI
@testable import stock_portfolio_tracker

class StringExtensionTests: XCTestCase {
    
    func testLeftTrim() {
        let test = "test"
        let string = "     \(test)".trim()
        XCTAssertEqual(string, test)
    }
    
    func testRightTrim() {
        let test = "test"
        let string = "\(test)     ".trim()
        XCTAssertEqual(string, test)
    }
    
    func testTrim() {
        let test = "test"
        let string = "     \(test) ".trim()
        XCTAssertEqual(string, test)
    }

}
