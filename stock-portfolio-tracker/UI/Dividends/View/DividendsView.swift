//
//  DividendsView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import SwiftUI
import DICE

struct DividendsView: View {
    
    @EnvironmentObservableInjected var viewModel: DividendsViewModel
    
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
            dividendsList
            .padding([.leading, .trailing], 18)
            .navigationBarTitle(Text("Dividends"))
            .navigationBarItems(trailing: addButton)
        }
    }
    
    var dividendsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.dividends) { dividend in
                    NavigationLink(
                        destination: dividendView(dividend),
                        tag: dividend.id,
                        selection: $viewModel.routingState.dividendDetails) {
                        DividendRow(item: dividend)
                    }
                }
            }
        }
    }
    
    var modalSheet: some View {
        switch viewModel.routingState.currentModalSheet {
        case .addDividend:
            return AnyView(AddDividendView())
        case .none:
            return AnyView(Text(""))
        }
    }
    
    var addButton: some View {
        Button(
            action: viewModel.input.addAction,
            label: { Image(systemName: "plus").imageScale(.large) }
        )
    }
    
    func dividendView(_ item: DividendViewItem) -> some View {
        DividendView()
    }
    
}

// MARK: - Preview

#if DEBUG
struct DividendsViewPreviews: PreviewProvider {
    static var previews: some View {
        DividendsView()
    }
}
#endif
