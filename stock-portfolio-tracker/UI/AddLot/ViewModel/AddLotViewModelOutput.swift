//
//  AddLotViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

protocol AddLotViewModelOutputType {
    var state: AddLotViewState { get }
    var title: String? { get }
    
    var feeCurrencyOptions: [CurrencyViewItem] { get }
}
