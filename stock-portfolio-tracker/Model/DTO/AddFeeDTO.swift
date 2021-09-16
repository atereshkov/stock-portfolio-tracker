//
//  AddFeeDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

struct AddFeeDTO {
    var type: String
    var ticker: String
    var date: Date
    var fee: MoneyDTO
    
    func toDto() -> [String: Any] {
        return [
            "date": date,
            "fee": fee.toDto(),
            "ticker": ticker,
            "type": type
        ]
    }
}
