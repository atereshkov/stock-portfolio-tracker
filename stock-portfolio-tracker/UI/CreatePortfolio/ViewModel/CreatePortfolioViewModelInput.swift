//
//  CreatePortfolioViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Foundation

protocol CreatePortfolioViewModelInputType {
    func create(currencyIndex: Int)
    
    func onDisappear()
    
    var name: String? { get set }
}
