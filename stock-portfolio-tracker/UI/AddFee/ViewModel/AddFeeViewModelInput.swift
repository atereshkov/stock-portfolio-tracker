//
//  AddFeeViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

protocol AddFeeViewModelInputType {
    func add(portfolioIndex: Int, tickerIndex: Int, currencyIndex: Int, date: Date)
    
    func onAppear()
    func onDisappear()
    
    var paid: String? { get set }
    var tax: String? { get set }
    var portfolioIndex: Int? { get set }
}
