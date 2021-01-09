//
//  PortfolioRow.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Foundation
import SwiftUI

struct PortfolioRow: View {
    var item: PortfolioViewItem

    var body: some View {
        HStack {
            Text(item.name)
        }
    }
}
