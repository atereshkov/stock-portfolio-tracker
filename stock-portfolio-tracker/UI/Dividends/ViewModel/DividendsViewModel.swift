//
//  DividendsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import Combine
import Foundation

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
        
        $dividends.sink { [weak self] in
            let sum = $0.reduce(0) { $0 + $1.paid.value }
            self?.dividendsValue = NSDecimalNumber(decimal: sum).stringValue
            self?.dividendsSign = $0.first?.paid.currency.symbol
        }.store(in: cancelBag)
    }
    
    // MARK: - Output
    
    @Published var routingState: DividendsRouting
    @Published var dividends: [DividendViewItem] = []
    @Published var dividendsValue: String?
    @Published var dividendsSign: String?
    
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB")
    ]
    
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
