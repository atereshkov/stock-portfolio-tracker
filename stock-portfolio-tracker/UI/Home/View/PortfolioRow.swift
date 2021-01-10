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
            VStack(alignment: .leading) {
                Text(item.name)
                Text(item.currency)
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#if DEBUG
struct PortfolioRowViewPreviews: PreviewProvider {
    static var previews: some View {
        PortfolioRow(item: PortfolioViewItem(id: "1", name: "Name1", currency: "$"))
            .previewLayout(.fixed(width: 375, height: 40))
    }
}
#endif
