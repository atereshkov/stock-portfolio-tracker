//
//  DividendRepositoryType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation
import Combine

protocol DividendRepositoryType {
    
    func addDividend(_ dto: AddDividendDTO, portfolioId: String) -> Future<Void, Error>
    
}
