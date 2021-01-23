//
//  DividendRepositoryType.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation
import Combine

protocol DividendRepositoryType {
    
    func loadDividends(limit: Int) -> Future<[DividendDTO], Error>
    
    func loadPagedDividends(limit: Int, lastItem: DividendViewItem) -> Future<[DividendDTO], Error>
    
    func addDividend(_ dto: AddDividendDTO, portfolioId: String) -> Future<Void, Error>
    
}
