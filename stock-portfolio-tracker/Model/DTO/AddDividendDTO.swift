//
//  AddDividendDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

struct AddDividendDTO {
    var portfolioId: String
    var ticker: String
    var date: Date
    var paid: MoneyDTO
    var tax: Double
    
    func toDto() -> [String: Any] {
        return [
            "portfolioId": portfolioId,
            "date": date,
            "paid": paid.toDto(),
            "tax": tax,
            "ticker": ticker
        ]
    }
}
