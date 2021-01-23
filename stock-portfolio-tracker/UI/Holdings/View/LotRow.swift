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
                HStack {
                    sharesText
                    Text(" | ")
                    sharePriceText
                    costText
                }
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    var sharesText: some View {
        item.shares == 1 ? Text("\(item.shares) share") : Text("\(item.shares) shares")
    }
    
    var sharePriceText: some View {
        Text("\(NSDecimalNumber(decimal: item.cost.value).stringValue) \(item.cost.currency.symbol)")
    }
    
    var costText: some View {
        let cost = item.cost.value * Decimal(item.shares)
        let costStr = NSDecimalNumber(decimal: cost).stringValue
        if item.shares > 1 {
            return AnyView(Text("(\(costStr) \(item.cost.currency.symbol))"))
        } else {
            return AnyView(Text(""))
        }
    }
    
}

#if DEBUG
struct LotRowViewPreviews: PreviewProvider {
    static var previews: some View {
        LotRow(item: LotViewItem(
                id: "",
                shares: 0,
                cost: MoneyViewItem(value: 0.0, currency: Currency(code: "USD")),
                fee: MoneyViewItem(value: 0.0, currency: Currency(code: "USD")),
                date: Date())
        )
        .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
