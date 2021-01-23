//
//  HoldingViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct HoldingViewItem: Identifiable, Equatable {
    var id: String
    var ticker: TickerViewItem
    
    var portfolioId: String
    
    static func from(_ dto: HoldingDTO) -> HoldingViewItem {
        return HoldingViewItem(
            id: dto.id,
            ticker: TickerViewItem.from(dto.ticker),
            portfolioId: dto.portfolioId
        )
    }
}
