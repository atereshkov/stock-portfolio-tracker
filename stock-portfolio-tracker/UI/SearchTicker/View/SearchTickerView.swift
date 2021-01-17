//
//  SearchTickerView.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/15/21.
//

import SwiftUI
import DICE

struct SearchTickerView: View {
    
    @EnvironmentObservableInjected var viewModel: SearchTickerViewModel
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    init(delegate: SearchTickerDelegate?) {
        viewModel.delegate = delegate
    }
    
    var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }
    
    var content: some View {
        NavigationView {
            VStack(alignment: .leading) {
                searchBar
                tickers
            }
            .padding([.leading, .trailing], 18)
            .navigationBarTitle("Search symbol")
        }
    }
    
    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding([.leading], 12)
                
                TextField("Search for symbols or companies", text: $searchText, onEditingChanged: { _ in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                })
                .foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding([.trailing], 6)
                        .opacity(searchText == "" ? 0 : 1)
                })
                if showCancelButton {
                    Button("Cancel") {
                        self.searchText = ""
                        self.showCancelButton = false
                    }
                    .padding([.trailing], 12)
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding([.top, .bottom], 8)
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
    }
    
    var tickers: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tickers) { ticker in
                    TickerRow(item: ticker)
                        .onTapGesture { [weak viewModel] in
                            viewModel?.input.onRowTapAction(ticker)
                        }
                }
            }
        }
    }
    
}
