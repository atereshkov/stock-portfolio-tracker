//
//  PortfolioView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import SwiftUI
import DICE

struct PortfolioView: View {
    
    init(item: PortfolioViewItem) {
        viewModel.portfolio = item
    }
    
    @EnvironmentObservableInjected var viewModel: PortfolioViewModel
    
    var body: some View {
        content
            .onDisappear(perform: viewModel.onDisappear)
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text("Portfolio \(viewModel.portfolio?.name ?? "")")
                .padding()
            portfoliosSection
        }
//        .navigationBarTitle(Text("Dashboard"), displayMode: .inline)
        .navigationBarItems(trailing: settingsNavBarIcon)
    }
    
    var settingsNavBarIcon: some View {
        Button(
            action: { [weak viewModel] in
                viewModel?.settingsAction()
            },
            label: { Image(systemName: "gearshape").imageScale(.large) }
        )
    }
    
    var portfoliosSection: some View {
        HStack {
            Text("Portfolios")
            Spacer()
            Button(action: { [weak viewModel] in
                viewModel?.input.addTickerAction()
            }, label: {
                Image(systemName: "plus")
            })
        }
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .settings:
            return AnyView(PortfolioSettingsView())
        case .addTicker:
            return AnyView(SearchTickerView())
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
