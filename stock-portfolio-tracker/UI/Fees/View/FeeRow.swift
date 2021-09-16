//
//  FeeRow.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Foundation
import SwiftUI

struct FeeRow: View {
    var item: FeeViewItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.id)
                Text(NSDecimalNumber(decimal: item.fee.value).stringValue)
                Divider()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
