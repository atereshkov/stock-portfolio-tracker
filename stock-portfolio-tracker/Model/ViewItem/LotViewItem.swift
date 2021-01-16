//
//  LotViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct LotViewItem: Identifiable, Equatable {
    var id: String
    var shares: Int
    var cost: MoneyViewItem
    var fee: MoneyViewItem
    var date: Date
    
    static func from(_ dto: LotDTO) -> LotViewItem {
        return LotViewItem(
            id: dto.id,
            shares: dto.shares,
            cost: MoneyViewItem.from(dto.cost),
            fee: MoneyViewItem.from(dto.fee),
            date: Date(timeIntervalSince1970: dto.date)
        )
    }
}
