//
//  SearchTickerViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/15/21.
//

import Foundation

protocol SearchTickerViewModelInputType {
    func onRowTapAction(_ ticker: TickerViewItem)
    
    func onDisappear()
}
