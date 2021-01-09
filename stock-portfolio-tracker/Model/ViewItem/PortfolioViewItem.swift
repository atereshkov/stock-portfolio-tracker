//
//  PortfolioDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Foundation

struct PortfolioViewItem: Hashable, Identifiable {
    var id: Int
    var name: String
    var currency: String
}
