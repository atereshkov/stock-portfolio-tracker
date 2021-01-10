//
//  PortfolioSettingsView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct PortfolioSettingsView: View {
    
    @EnvironmentObservableInjected var viewModel: PortfolioSettingsViewModel
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        Text("Portfolio Settings")
    }
    
}
