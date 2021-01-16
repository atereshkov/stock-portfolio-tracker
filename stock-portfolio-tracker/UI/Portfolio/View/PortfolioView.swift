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
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            holdingsSection
                .padding([.top], 12)
            holdings
        }
        .padding([.leading, .trailing], 18)
        .navigationBarTitle(viewModel.portfolio?.name ?? "", displayMode: .inline)
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
    
    var holdingsSection: some View {
        HStack {
            Text("Holdings")
            Spacer()
            Button(action: { [weak viewModel] in
                viewModel?.input.addTickerAction()
            }, label: {
                Image(systemName: "plus").imageScale(.large)
            })
        }
    }
    
    var holdings: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.holdings) { holding in
                    NavigationLink(
                        destination: holdingsView(holding),
                        tag: holding.id,
                        selection: $viewModel.routingState.holdingDetails) {
                        HoldingRow(item: holding)
                    }
                }
            }
        }
    }
    
    func holdingsView(_ holding: HoldingViewItem) -> some View {
        guard let portfolio = viewModel.portfolio else { return AnyView(Text("")) }
        return AnyView(HoldingsView(portfolio: portfolio, holding: holding))
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .settings:
            return AnyView(PortfolioSettingsView())
        case .addTicker:
            return AnyView(SearchTickerView(delegate: viewModel))
        case .none:
            return AnyView(Text(""))
        }
    }
    
}

// MARK: - Preview

#if DEBUG
struct PortfolioViewPreviews: PreviewProvider {
    static var previews: some View {
        PortfolioView(item: PortfolioViewItem(id: "", name: "", currency: ""))
    }
}
#endif
