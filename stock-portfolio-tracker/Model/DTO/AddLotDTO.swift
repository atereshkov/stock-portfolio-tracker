//
//  AddLotDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct AddLotDTO {
    var ticker: String
    var date: Date
    var cost: MoneyDTO
    var fee: MoneyDTO
    var shares: Int
    
    func toDto() -> [String: Any] {
        return [
            "date": date,
            "cost": cost.toDto(),
            "fee": fee.toDto(),
            "ticker": ticker,
            "shares": shares
        ]
    }
}
