//
//  SearchTickerViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/15/21.
//

import Combine
import SwiftUI

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
    
    // MARK: - Output
    
    @Published var routingState: SearchTickerRouting
    @Published var state: SearchTickerViewState = .start
    
}

// MARK: - SearchTickerViewModelInputType

extension SearchTickerViewModel: SearchTickerViewModelInputType {
    
    func onDisappear() {
        session.appState[\.routing.searchTicker.isPresented] = false
        cancelBag.cancel()
    }
    
}

// MARK: - SearchTickerViewModelOutputType

extension SearchTickerViewModel: SearchTickerViewModelOutputType {
    
}
