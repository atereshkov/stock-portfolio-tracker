//
//  TickerRow.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation
import SwiftUI

struct TickerRow: View {
    var item: TickerViewItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.id)
                Text(item.ticker)
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
struct TickerRowViewPreviews: PreviewProvider {
    static var previews: some View {
        TickerRow(item: TickerViewItem(id: "1", ticker: "Name1", currencyCode: "USD"))
            .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
