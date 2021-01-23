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
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.ticker).bold()
                    Text(item.ticker)
                }
                Spacer()
                HStack {
                    HStack {
                        Text(item.paid.currency.symbol)
                        Text(NSDecimalNumber(decimal: item.paid.value).stringValue)
                            .foregroundColor(.green)
                    }
                    Image(systemName: "arrow.right")
                        .opacity(0.5)
                }
            }
            Divider()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
