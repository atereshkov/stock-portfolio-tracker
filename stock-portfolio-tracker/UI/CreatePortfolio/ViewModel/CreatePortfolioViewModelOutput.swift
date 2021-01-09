//
//  CreatePortfolioViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Foundation

protocol CreatePortfolioViewModelOutputType {
    var title: String? { get }
    var currencyOptions: [String] { get }
}
