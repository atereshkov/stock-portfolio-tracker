//
//  HomeView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import SwiftUI
import DICE

struct HomeView: View {
    
    @EnvironmentObservableInjected var viewModel: HomeViewModel
    
    var body: some View {
        content
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }
    
    var content: some View {
        NavigationView {
            VStack(alignment: .leading) {
                portfoliosRow
                portfolios
            }
            .padding([.leading, .trailing], 18)
            .navigationBarTitle(Text("Dashboard"))
            .navigationBarItems(trailing: accountButton)
        }
    }
    
    var portfoliosRow: some View {
        HStack {
            Text("Portfolios")
            Spacer()
            Button(action: {
                viewModel.input.newPortfolioAction()
            }, label: {
                Image(systemName: "plus")
            })
        }
    }
    
    var portfolios: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.portfolios) { portfolio in
                    NavigationLink(
                        destination: portfolioView(portfolio),
                        tag: portfolio.id,
                        selection: $viewModel.routingState.portfolioDetails) {
                        PortfolioRow(item: portfolio)
                    }
                }
            }
        }
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .account:
            return AnyView(AccountView())
        case .createPortfolio:
            return AnyView(CreatePortfolioView())
        case .none:
            return AnyView(Text(""))
        }
    }
    
    var accountButton: some View {
        Button(
            action: viewModel.accountAction,
            label: { Image(systemName: "person.crop.circle").imageScale(.large) }
        )
    }
    
    func portfolioView(_ item: PortfolioViewItem) -> some View {
        PortfolioView()
    }
    
}

// MARK: - Preview

#if DEBUG
struct HomeViewPreviews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
