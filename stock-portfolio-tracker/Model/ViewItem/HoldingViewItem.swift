//
//  HoldingViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct HoldingViewItem: Identifiable, Equatable {
    var id: String
    var ticker: String
    
    var portfolioId: String
    
    static func from(_ dto: HoldingDTO) -> HoldingViewItem {
        return HoldingViewItem(id: dto.id, ticker: dto.ticker, portfolioId: dto.portfolioId)
    }
}
