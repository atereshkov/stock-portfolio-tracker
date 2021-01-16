//
//  HoldingsViewModelInput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

protocol HoldingsViewModelInputType {
    var holding: HoldingViewItem? { get set }
    
    func addLotAction()
    
    func onAppear()
    func onDisappear()
}
