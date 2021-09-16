//
//  FeesViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import Foundation

class FeesViewModel: BaseViewModel<FeesViewModelInputType, FeesViewModelOutputType>, FeesViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.fees)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.fees] = $0 }
            
            session.appState.map(\.data.fees)
                .removeDuplicates()
                .assign(to: \.fees, on: self)
        }
        
        $fees.sink { [weak self] in
            let sum = $0.reduce(0) { $0 + $1.fee.value }
            self?.feesValue = NSDecimalNumber(decimal: sum).stringValue
            self?.feesSign = $0.first?.fee.currency.symbol
        }.store(in: cancelBag)
    }
    
    // MARK: - Output
    
    @Published var routingState: FeesRouting
    @Published var fees: [FeeViewItem] = []
    @Published var feesValue: String?
    @Published var feesSign: String?
    
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB")
    ]
    
}

// MARK: - FeesViewModelInputType

extension FeesViewModel: FeesViewModelInputType {
    
    func addAction() {
        routingState.currentModalSheet = .addFee
        routingState.showModalSheet = true
    }
    
}

// MARK: - FeesViewModelOutputType

extension FeesViewModel: FeesViewModelOutputType {
    
}
