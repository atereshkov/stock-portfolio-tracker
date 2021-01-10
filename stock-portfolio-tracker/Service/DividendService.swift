//
//  DividendService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import DICE
import Combine

protocol DividendServiceType {
    
    func addDividend() -> Future<Void, Error>
    
}

class DividendService: DividendServiceType {
    
    @Injected var dividendRepository: DividendRepositoryType
    
}

extension DividendService {
    
    func addDividend() -> Future<Void, Error> {
        return dividendRepository.addDividend()
    }
    
}
