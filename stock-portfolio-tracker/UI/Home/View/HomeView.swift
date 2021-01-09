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
                Section {
                    Text("Test 1")
                    Text("Test 2")
                }
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
            .padding([.leading, .trailing], 21)
            .navigationBarTitle(Text("Dashboard"))
        }
    }
    
    var modalSheet: some View {
        CreatePortfolio()
    }
    
//    func portfolioList(List<Portfolio> portfolios) -> View {
//        List(portfolios) { portfolio in
//            NavigationLink(
//                destination: portfolioView(portfolio: portfolio),
//                tag: country.alpha3Code,
//                selection: $viewModel.routingState.countryDetails) {
//                    PortfolioRow(portfolio: portfolio)
//                }
//        }
//    }
    
}
