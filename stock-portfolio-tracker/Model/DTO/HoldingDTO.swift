//
//  HoldingDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct HoldingDTO: Identifiable {
    var id: String
    var ticker: String
    
    var createdAt: Date
    var updatedAt: Date
    
    var portfolioId: String
    
    static func from(_ data: [String: Any]) -> HoldingDTO {
        let id = data["id"] as? String ?? ""
        let ticker = data["ticker"] as? String ?? ""
        let portfolioId = data["portfolioId"] as? String ?? ""
        
        return HoldingDTO(
            id: id,
            ticker: ticker,
            createdAt: Date(timeIntervalSince1970: data["createdAt"] as? Double ?? 0.0),
            updatedAt: Date(timeIntervalSince1970: data["updatedAt"] as? Double ?? 0.0),
            portfolioId: portfolioId
        )
    }
    
    func toDto() -> [String: Any] {
        return [
            "id": id,
            "ticker": ticker
        ]
    }
}
