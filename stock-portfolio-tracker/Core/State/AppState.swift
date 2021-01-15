//
//  AppState.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var auth = AuthState()
    var user = UserData()
    var data = DataState()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct AuthState: Equatable {
        var isAuthorized: Bool = false
    }
}

extension AppState {
    struct UserData: Equatable {
        var id: String?
    }
}

extension AppState {
    struct DataState: Equatable {
        var portfolios: [PortfolioViewItem] = []
        var dividends: [DividendViewItem] = []
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var auth = AuthRouting()
        var root = RootRouting()
        
        var login = LoginRouting()
        var signUp = SignUpRouting()
        
        var home = HomeRouting()
        var createPortfolio = CreatePortfolioRouting()
        var account = AccountRouting()
        var portfolio = PortfolioRouting()
        var portfolioSettings = PortfolioSettingsRouting()
        
        var dividends = DividendsRouting()
        var addDividend = AddDividendRouting()
        var dividend = DividendRouting()
        var searchTicker = SearchTickerRouting()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.auth == rhs.auth &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.user == rhs.user
}
