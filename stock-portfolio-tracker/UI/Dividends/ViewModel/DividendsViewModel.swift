//
//  DividendsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import Combine

class DividendsViewModel: BaseViewModel<DividendsViewModelInputType, DividendsViewModelOutputType>, DividendsViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.dividends)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.dividends] = $0 }
            
            session.appState.map(\.data.dividends)
                .removeDuplicates()
                .assign(to: \.dividends, on: self)
        }
    }
    
    // MARK: - Output
    
    @Published var routingState: DividendsRouting
    @Published var dividends: [DividendViewItem] = []
    
}

// MARK: - DividendsViewModelInputType

extension DividendsViewModel: DividendsViewModelInputType {
    
    func addAction() {
        routingState.currentModalSheet = .addDividend
        routingState.showModalSheet = true
    }
    
}

// MARK: - DividendsViewModelOutputType

extension DividendsViewModel: DividendsViewModelOutputType {
    
}
