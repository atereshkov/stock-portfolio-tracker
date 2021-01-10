//
//  PortfolioView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct PortfolioView: View {
    
    @EnvironmentObservableInjected var viewModel: PortfolioViewModel
    
    var body: some View {
        content
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }
    
    var content: some View {
        Text("Portfolio")
            .padding()
            .navigationBarItems(trailing: settingsNavBarIcon)
    }
    
    var settingsNavBarIcon: some View {
        Button(
            action: viewModel.settingsAction,
            label: { Image(systemName: "gearshape").imageScale(.large) }
        )
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .settings:
            return AnyView(PortfolioSettingsView())
        case .none:
            return AnyView(Text(""))
        }
    }
    
}

// MARK: - Preview

#if DEBUG
struct PortfolioViewPreviews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
