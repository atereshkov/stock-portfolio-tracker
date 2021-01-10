//
//  AddDividendViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

protocol AddDividendViewModelOutputType {
    var title: String? { get }
    
    var portfolioOptions: [PortfolioViewItem] { get }
    var tickerOptions: [TickerViewItem] { get }
}