//
//  HomeRouting.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Foundation

struct HomeRouting: Equatable {
    
    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: HomeModalRoutingType?
    
    // MARK: - Portfolio
    var portfolioDetails: Int?
    
}
