//
//  AddHoldingDTO.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation

struct AddHoldingDTO: Identifiable {
    var id: String
    var ticker: String
    
    func toDto() -> [String: Any] {
        return [
            "id": id,
            "ticker": ticker
        ]
    }
}
