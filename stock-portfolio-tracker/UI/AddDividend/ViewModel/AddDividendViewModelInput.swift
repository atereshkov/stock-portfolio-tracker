//
//  AddDividendViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

protocol AddDividendViewModelInputType {
    func create(currencyIndex: Int)
    
    func onDisappear()
    
    var name: String? { get set }
}
