//
//  FeeTypeViewItem.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation

struct FeeTypeViewItem: Identifiable {
    var id: String
    var type: String
    
    func localizedType() -> String {
        switch type {
        case "other":
            return "Other"
        case "monthly":
            return "Monthly"
        case "buy":
            return "Buy"
        case "sell":
            return "Sell"
        default:
            return ""
        }
    }
}
