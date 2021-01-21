//
//  FeeDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

struct FeeDTO: Identifiable {
    var id: String
    var fee: MoneyDTO
    var date: Double
    
    static func from(_ vi: FeeViewItem) -> FeeDTO {
        return FeeDTO(
            id: vi.id,
            fee: MoneyDTO.from(vi.fee),
            date: vi.date.timeIntervalSince1970
        )
    }
    
    static func from(id: String, data: [String: Any]) -> FeeDTO? {
        let date = data["date"] as? Double ?? 0.0
        
        guard let feeData = data["fee"] as? [String: Any] else { return nil }
        let fee = MoneyDTO.from(feeData)
        
        return FeeDTO(
            id: id,
            fee: fee,
            date: date
        )
    }
}
