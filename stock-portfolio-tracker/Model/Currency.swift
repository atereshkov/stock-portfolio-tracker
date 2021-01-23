//
//  Currency.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/23/21.
//

import Foundation

let currencies: [String: String] = [
    "USD": "$",
    "EUR": "€",
    "BYN": "Br",
    "RUB": "₽"
]

struct Currency: Equatable, Hashable {
    let code: String
    
    var symbol: String {
        return currencies.first(where: { $0.key == code })?.value ?? ""
    }
}
