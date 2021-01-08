//
//  AuthServiceStub.swift
//  stock-portfolio-trackerTests
//
//  Created by nb-058-41b on 1/9/21.
//

import Combine

@testable import stock_portfolio_tracker

class AuthServiceStub: AuthServiceType {
    
    func createUser(email: String, password: String) -> Future<Void, Error> {
        return Future {_ in
            
        }
    }
    
    func signIn(email: String, password: String) -> Future<Void, Error> {
        return Future {_ in 
            
        }
    }
    
    func logout() {
        
    }
    
}
