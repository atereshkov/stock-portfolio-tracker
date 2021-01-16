//
//  AddLotViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

protocol AddLotViewModelInputType {
    func add(currencyIndex: Int, date: Date)
    
    func onDisappear()
    
    var holding: HoldingViewItem? { get set }
    var cost: String? { get set }
    var fee: String? { get set }
    var shares: String? { get set }
}
