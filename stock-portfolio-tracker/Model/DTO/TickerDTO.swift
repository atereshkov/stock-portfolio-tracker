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
    var currencyCode: String
    
    static func from(_ vi: TickerViewItem) -> TickerDTO {
        return TickerDTO(id: vi.id, ticker: vi.ticker, currencyCode: vi.currencyCode)
    }
    
    static func from(_ data: [String: Any]) -> TickerDTO {
        let id = data["id"] as? String ?? ""
        let ticker = data["ticker"] as? String ?? ""
        let currencyCode = data["currencyCode"] as? String ?? ""
        return TickerDTO(id: id, ticker: ticker, currencyCode: currencyCode)
    }
    
    func toDto() -> [String: Any] {
        return [
            "id": id,
            "ticker": ticker,
            "currencyCode": currencyCode
        ]
    }
}
