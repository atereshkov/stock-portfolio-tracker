//
//  PortfolioViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation

protocol PortfolioViewModelInputType {
    var portfolio: PortfolioViewItem? { get set }
    
    func settingsAction()
    func addTickerAction()
    
    func onAppear()
    func onDisappear()
}
