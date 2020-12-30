//
//  StringExtensions.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 12/30/20.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
