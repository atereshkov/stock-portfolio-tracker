//
//  AddFeeViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

protocol AddFeeViewModelOutputType {
    var state: AddFeeViewState { get }
    var title: String? { get }
    
    var portfolioOptions: [PortfolioViewItem] { get }
    var currencyOptions: [CurrencyViewItem] { get }
    var tickerOptions: [TickerViewItem] { get }
    
    func selectedTicker(_ index: Int) -> TickerViewItem?
}
