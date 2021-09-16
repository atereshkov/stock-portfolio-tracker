//
//  DividendsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/8/21.
//

import Combine
import Foundation

class DividendsViewModel: BaseViewModel<DividendsViewModelInputType, DividendsViewModelOutputType>, DividendsViewModelType {
    
    private let dividendService: DividendServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.dividendService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.dividends)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.dividends] = $0 }
            
            session.appState.map(\.data.dividends)
                .removeDuplicates()
                .map { dividends in
                    return dividends
//                    return dividends.sorted(by: { $0.createdAt > $1.createdAt })
                }
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
    
    func onAppear() {
        _ = dividendService.loadDividends(limit: 20)
    }
    
    func onRowAppear(item: DividendViewItem) {
        guard dividends.firstIndex(of: item) == dividends.count - 1 else { return }
        guard let lastItem = dividends.last else { return }
        _ = dividendService.loadPagedDividends(limit: 20, lastItem: lastItem)
    }
    
}

// MARK: - DividendsViewModelOutputType

extension DividendsViewModel: DividendsViewModelOutputType {
    
}
