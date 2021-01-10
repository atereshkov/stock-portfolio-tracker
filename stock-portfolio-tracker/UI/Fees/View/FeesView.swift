//
//  FeesView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct FeesView: View {
    
    @EnvironmentObservableInjected var viewModel: FeesViewModel
    
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
            .navigationBarTitle(Text("Fees"))
        }
    }
    
}
