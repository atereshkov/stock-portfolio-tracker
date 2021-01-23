//
//  DividendDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/23/21.
//

import Foundation

struct DividendDTO: Identifiable {
    var id: String
    var portfolioId: String
    var ticker: String
    var date: Date
    var createdAt: Date
    var updatedAt: Date
    var paid: MoneyDTO
    var tax: Double
    
    static func from(id: String, data: [String: Any]) -> DividendDTO {
        let id = data["id"] as? String ?? id
        let ticker = data["ticker"] as? String ?? ""
        let portfolioId = data["portfolioId"] as? String ?? ""
        let tax = data["tax"] as? Double ?? 0.0
        let paid = MoneyDTO.from(data["paid"] as? [String: Any] ?? [:])
        
        return DividendDTO(
            id: id,
            portfolioId: portfolioId,
            ticker: ticker,
            date: Date(timeIntervalSince1970: data["date"] as? Double ?? 0.0),
            createdAt: Date(timeIntervalSince1970: data["createdAt"] as? Double ?? 0.0),
            updatedAt: Date(timeIntervalSince1970: data["updatedAt"] as? Double ?? 0.0),
            paid: paid,
            tax: tax
        )
    }
}
