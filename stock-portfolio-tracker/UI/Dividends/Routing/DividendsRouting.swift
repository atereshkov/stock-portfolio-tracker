//
//  DividendsRouting.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

struct DividendsRouting: Equatable {
    
    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: DividendsModalRoutingType?
    
    // MARK: - Dividend
    var dividendDetails: String?
    
}
