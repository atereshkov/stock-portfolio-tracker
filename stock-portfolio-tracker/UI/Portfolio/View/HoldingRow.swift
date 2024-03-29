//
//  HoldingRow.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation
import SwiftUI

struct HoldingRow: View {
    var item: HoldingViewItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.id)
                Text(item.ticker.ticker)
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
struct HoldingRowViewPreviews: PreviewProvider {
    static var previews: some View {
        let item = HoldingViewItem(id: "1", ticker: TickerViewItem(id: "", ticker: "", currencyCode: ""), portfolioId: "")
        return HoldingRow(item: item)
            .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
