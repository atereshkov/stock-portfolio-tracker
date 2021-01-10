//
//  TransactionsView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct TransactionsView: View {
    
    @EnvironmentObservableInjected var viewModel: TransactionsViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Text("Hello World")
                    }
                }
            }
            .navigationBarTitle(Text("Transactions"))
        }
    }
    
}
