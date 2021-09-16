//
//  FeesRouting.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

struct FeesRouting: Equatable {
    
    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: FeesModalRoutingType?
    
    // MARK: - Fee
    var feeDetails: String?
    
}
