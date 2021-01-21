//
//  FeeViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

struct FeeViewItem: Identifiable, Equatable {
    var id: String
    var fee: MoneyViewItem
    var date: Date
    
    static func from(_ dto: FeeDTO) -> FeeViewItem {
        return FeeViewItem(
            id: dto.id,
            fee: MoneyViewItem.from(dto.fee),
            date: Date(timeIntervalSince1970: dto.date)
        )
    }
}
