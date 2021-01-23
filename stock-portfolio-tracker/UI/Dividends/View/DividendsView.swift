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
    
    @State var currencyIndex: Int = 0
    
    var body: some View {
        content
            .onAppear(perform: viewModel.input.onAppear)
            .sheet(
                isPresented: $viewModel.routingState.showModalSheet,
                content: {
                    modalSheet
                })
    }
    
    var content: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Picker(viewModel.output.dividendsSign ?? "", selection: $currencyIndex) {
                        ForEach(0..<viewModel.currencyOptions.count) { index in
                            Text(viewModel.currencyOptions[index].name).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Text(viewModel.output.dividendsValue ?? "")
                }
                .padding(.top, 12)
                dividendsList
            }
            .padding([.leading, .trailing], 18)
            .navigationBarTitle(Text("Dividends"), displayMode: .inline)
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
                            .onAppear(perform: { [weak viewModel] in
                                viewModel?.input.onRowAppear(item: dividend)
                            })
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
        DividendView(item: item)
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
