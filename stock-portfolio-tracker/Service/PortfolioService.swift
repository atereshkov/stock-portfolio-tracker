//
//  PortfolioService.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import DICE
import Combine

protocol PortfolioServiceType {
    
    func createPortfolio(name: String, currency: String) -> Future<Void, Error>
    
    func addTicker(ticker: TickerDTO, portfolioId: String) -> Future<Void, Error>
    
}

class PortfolioService: PortfolioServiceType {
    
    @Injected var portfolioRepository: PortfolioRepositoryType
    
}

extension PortfolioService {
    
    func createPortfolio(name: String, currency: String) -> Future<Void, Error> {
        return portfolioRepository.createPortfolio(name: name, currency: currency)
    }
    
    func addTicker(ticker: TickerDTO, portfolioId: String) -> Future<Void, Error> {
        return portfolioRepository.addTicker(ticker: ticker, portfolioId: portfolioId)
    }
    
}
