//
//  MoneyViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/14/21.
//

import Foundation

struct MoneyViewItem: Hashable, Identifiable {
    
    var id: String {
        return currency
    }
    
    var value: Decimal
    var currency: String
    
    static func from(_ dto: MoneyDTO) -> MoneyViewItem {
        return MoneyViewItem(value: dto.value, currency: dto.currency)
    }
}
