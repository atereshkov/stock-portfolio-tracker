//
//  FeesViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

protocol FeesViewModelOutputType {
    var routingState: FeesRouting { get }
    var fees: [FeeViewItem] { get }
    var currencyOptions: [CurrencyViewItem] { get }
    var feesValue: String? { get }
    var feesSign: String? { get }
}
