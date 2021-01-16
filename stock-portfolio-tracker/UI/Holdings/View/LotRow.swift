//
//  LotRow.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Foundation
import SwiftUI

struct LotRow: View {
    var item: LotViewItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.id)
                Text("\(item.shares)")
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
struct LotRowViewPreviews: PreviewProvider {
    static var previews: some View {
        LotRow(item: LotViewItem(
                id: "",
                shares: 0,
                cost: MoneyViewItem(value: 0.0, currency: ""),
                fee: MoneyViewItem(value: 0.0, currency: ""),
                date: Date())
        )
        .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
