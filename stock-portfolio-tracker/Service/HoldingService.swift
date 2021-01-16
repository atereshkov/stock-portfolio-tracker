//
//  HoldingService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import DICE
import Combine

protocol HoldingServiceType {
    
    func addHolding(holding: HoldingDTO, portfolioId: String) -> Future<Void, Error>
    
}

class HoldingService: HoldingServiceType {
    
    @Injected var holdingRepository: HoldingRepositoryType
    
}

extension HoldingService {
    
    func addHolding(holding: HoldingDTO, portfolioId: String) -> Future<Void, Error> {
        return holdingRepository.addHolding(holding: holding, portfolioId: portfolioId)
    }
    
}
