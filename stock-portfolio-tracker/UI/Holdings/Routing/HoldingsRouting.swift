//
//  HoldingsRouting.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

struct HoldingsRouting: Equatable {
    
    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: HoldingsModalRoutingType?
    
    // MARK: - Lots
    var lotDetails: String?
    
}
