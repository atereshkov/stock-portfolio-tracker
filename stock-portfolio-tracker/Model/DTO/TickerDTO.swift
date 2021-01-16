//
//  TickerDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct TickerDTO: Identifiable {
    var id: String
    var ticker: String
    
    static func from(_ viewItem: TickerViewItem) -> TickerDTO {
        return TickerDTO(id: viewItem.id, ticker: viewItem.ticker)
    }
    
    static func from(_ data: [String: Any]) -> TickerDTO {
        let id = data["id"] as? String ?? ""
        let ticker = data["ticker"] as? String ?? ""
        return TickerDTO(id: id, ticker: ticker)
    }
    
    func toDto() -> [String: Any] {
        return [
            "id": id,
            "ticker": ticker
        ]
    }
}
