//
//  FeeRepositoryType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation
import Combine

protocol FeeRepositoryType {
    
    func addFee(_ dto: AddFeeDTO, portfolioId: String?, tickerId: String?) -> Future<Void, Error>
    
}
