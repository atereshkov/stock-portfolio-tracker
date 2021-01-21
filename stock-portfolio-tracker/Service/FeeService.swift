//
//  FeeService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import DICE
import Combine

protocol FeeServiceType {
    
    func addFee(_ dto: AddFeeDTO, portfolioId: String?, tickerId: String?) -> Future<Void, Error>
    
}

class FeeService: FeeServiceType {
    
    @Injected var feeRepository: FeeRepositoryType
    
}

extension FeeService {
    
    func addFee(_ dto: AddFeeDTO, portfolioId: String?, tickerId: String?) -> Future<Void, Error> {
        return feeRepository.addFee(dto, portfolioId: portfolioId, tickerId: tickerId)
    }
    
}
