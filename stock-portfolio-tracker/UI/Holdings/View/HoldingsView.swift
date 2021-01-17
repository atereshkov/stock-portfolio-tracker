//
//  HoldingsView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import SwiftUI
import DICE

struct HoldingsView: View {
    
    init(portfolio: PortfolioViewItem, holding: HoldingViewItem) {
        viewModel.portfolio = portfolio
        viewModel.holding = holding
    }
    
    @EnvironmentObservableInjected var viewModel: HoldingsViewModel
    
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
            lots.padding(.top, 12)
        }
        .padding([.leading, .trailing], 18)
        .navigationBarTitle(viewModel.holding?.ticker ?? "", displayMode: .inline)
        .navigationBarItems(trailing: addLotNavBarIcon)
    }
    
    var addLotNavBarIcon: some View {
        Button(
            action: { [weak viewModel] in
                viewModel?.addLotAction()
            },
            label: { Image(systemName: "plus").imageScale(.large) }
        )
    }
    
    var lots: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.lots, id: \.id) { lot in
                    NavigationLink(destination: lotView(lot)) {
                        LotRow(item: lot)
                    }
                }
            }
        }
    }
    
    func lotView(_ item: LotViewItem) -> some View {
        return Text("\(item.shares)")
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addLot:
            return AnyView(AddLotView(portfolio: viewModel.portfolio, holding: viewModel.holding))
        case .none:
            return AnyView(Text(""))
        }
    }
    
}

// MARK: - Preview

#if DEBUG
struct HoldingsViewPreviews: PreviewProvider {
    static var previews: some View {
//        HoldingsView()
        Text("")
    }
}
#endif
