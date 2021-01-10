//
//  DividendRow.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Foundation
import SwiftUI

struct DividendRow: View {
    var item: DividendViewItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.ticker)
                Text("\(item.paid)")
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
