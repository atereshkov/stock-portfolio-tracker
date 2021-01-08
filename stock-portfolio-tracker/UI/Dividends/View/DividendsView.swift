//
//  DividendsView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import SwiftUI
import DICE

struct DividendsView: View {
    
    @EnvironmentObservableInjected var viewModel: HomeViewModel
    
    var body: some View {
        content
    }
    
    var content: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        Text("Hello World")
                        Text("Hello World")
                    }
                }
            }
            .navigationBarTitle(Text("Dividends"))
        }
    }
    
}
