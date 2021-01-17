//
//  SearchTickerViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/15/21.
//

import Combine
import SwiftUI

protocol SearchTickerDelegate: class {
    func onTickerSelected(_ ticker: TickerViewItem)
}

class SearchTickerViewModel: BaseViewModel<SearchTickerViewModelInputType, SearchTickerViewModelOutputType>, SearchTickerViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.searchTicker)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.searchTicker] = $0 }
            session.appState.map(\.routing.searchTicker)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
    }
    
    deinit {
        Swift.print("[SearchTickerViewModel] Deinit")
    }
    
    // MARK: - Input
    
    weak var delegate: SearchTickerDelegate?
    
    // MARK: - Output
    
    @Published var routingState: SearchTickerRouting
    @Published var state: SearchTickerViewState = .start
    @Published var tickers: [TickerViewItem] = [
        TickerViewItem(id: "AAPL", ticker: "AAPL"),
        TickerViewItem(id: "SPY", ticker: "SPY"),
        TickerViewItem(id: "VOO", ticker: "VOO"),
        TickerViewItem(id: "IBM", ticker: "IBM")
    ]
    
}

// MARK: - SearchTickerViewModelInputType

extension SearchTickerViewModel: SearchTickerViewModelInputType {
    
    func onRowTapAction(_ ticker: TickerViewItem) {
        delegate?.onTickerSelected(ticker)
        onDisappear()
    }
    
    func onAppear() {
        routingState.isPresented = true
    }
    
    func onDisappear() {
        routingState.isPresented = false
        cancelBag.cancel()
    }
    
}

// MARK: - SearchTickerViewModelOutputType

extension SearchTickerViewModel: SearchTickerViewModelOutputType {
    
}
