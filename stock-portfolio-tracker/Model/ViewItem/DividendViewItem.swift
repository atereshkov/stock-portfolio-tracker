//
//  DividendViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

struct DividendViewItem: Hashable, Identifiable {
    var id: String
    var ownerId: String
    var portfolioId: String
    var ticker: String
    var date: Date
    var paid: MoneyViewItem
    var tax: Double
}
