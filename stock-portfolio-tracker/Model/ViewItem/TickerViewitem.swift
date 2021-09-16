//
//  TickerViewitem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

struct TickerViewItem: Identifiable, Equatable {
    var id: String
    var ticker: String
    var currencyCode: String
    
    static func from(_ dto: TickerDTO) -> TickerViewItem {
        return TickerViewItem(id: dto.id, ticker: dto.ticker, currencyCode: dto.currencyCode)
    }
}
