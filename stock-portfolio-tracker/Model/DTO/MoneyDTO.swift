//
//  MoneyDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/14/21.
//

import Foundation

struct MoneyDTO {
    var value: Decimal
    var currency: Currency
    
    static func from(_ data: [String: Any]) -> MoneyDTO {
        let value = (data["value"] as? NSNumber)?.decimalValue ?? 0.0
        let currencyCode = data["currency"] as? String ?? ""
        return MoneyDTO(value: value, currency: Currency(code: currencyCode))
    }
    
    static func from(_ vi: MoneyViewItem) -> MoneyDTO {
        return MoneyDTO(value: vi.value, currency: vi.currency)
    }
    
    func toDto() -> [String: Any] {
        return [
            "value": value,
            "currency": currency
        ]
    }
}
