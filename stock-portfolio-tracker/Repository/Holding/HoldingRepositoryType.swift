//
//  HoldingRepositoryType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation
import Combine

protocol HoldingRepositoryType {
    
    func addHolding(holding: HoldingDTO, portfolioId: String) -> Future<Void, Error>
    
    func loadLots(portfolioId: String, holdingId: String) -> Future<[LotDTO], Error>
    
    func addLot(lot: AddLotDTO, portfolioId: String, holdingId: String) -> Future<Void, Error>
    
}
