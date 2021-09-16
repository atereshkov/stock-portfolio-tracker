//
//  DividendViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

struct DividendViewItem: Hashable, Identifiable {
    var id: String
    var portfolioId: String
    var ticker: String
    var createdAt: Date
    var date: Date
    var paid: MoneyViewItem
    var tax: Double
    
    static func from(_ dto: DividendDTO) -> DividendViewItem {
        return DividendViewItem(
            id: dto.id,
            portfolioId: dto.portfolioId,
            ticker: dto.ticker,
            createdAt: dto.createdAt,
            date: dto.date,
            paid: MoneyViewItem.from(dto.paid),
            tax: dto.tax
        )
    }
}
