//
//  LotDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct LotDTO: Identifiable {
    var id: String
    var shares: Int
    var cost: MoneyDTO
    var fee: MoneyDTO
    var date: Double
    
    static func from(_ vi: LotViewItem) -> LotDTO {
        return LotDTO(
            id: vi.id,
            shares: vi.shares,
            cost: MoneyDTO.from(vi.cost),
            fee: MoneyDTO.from(vi.fee),
            date: vi.date.timeIntervalSince1970
        )
    }
    
    static func from(id: String, data: [String: Any]) -> LotDTO? {
        let shares = data["shares"] as? Int ?? 0
        let date = data["date"] as? Double ?? 0.0
        
        guard let costData = data["cost"] as? [String: Any] else { return nil }
        let cost = MoneyDTO.from(costData)
        
        guard let feeData = data["fee"] as? [String: Any] else { return nil }
        let fee = MoneyDTO.from(feeData)
        
        return LotDTO(
            id: id,
            shares: shares,
            cost: cost,
            fee: fee,
            date: date
        )
    }
    
    func toDto() -> [String: Any] {
        return [
            "id": id
        ]
    }
}
