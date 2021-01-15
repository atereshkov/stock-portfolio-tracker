//
//  SearchTickerView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/15/21.
//

import SwiftUI
import DICE

struct SearchTickerView: View {
    
    @EnvironmentObservableInjected var viewModel: SearchTickerViewModel
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Empty")
            }.navigationBarTitle("Search symbol", displayMode: .inline)
        }
    }
    
}
