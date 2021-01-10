//
//  DividendView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct DividendView: View {
    
    @EnvironmentObservableInjected var viewModel: DividendViewModel
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        Text("Dividend")
    }
    
}
