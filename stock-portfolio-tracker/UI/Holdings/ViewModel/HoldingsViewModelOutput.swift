//
//  HoldingsViewModelOutput.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

protocol HoldingsViewModelOutputType {
    var routingState: HoldingsRouting { get }
    var lots: [LotViewItem] { get }
}
