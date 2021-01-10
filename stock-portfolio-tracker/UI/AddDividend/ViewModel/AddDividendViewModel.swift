//
//  AddDividendViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import SwiftUI

class AddDividendViewModel: BaseViewModel<AddDividendViewModelInputType, AddDividendViewModelOutputType>, AddDividendViewModelType {
    
    private let dividendService: DividendServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.dividendService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.addDividend)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.addDividend] = $0 }
            session.appState.map(\.routing.addDividend)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
        
        session.appState.map(\.data.portfolios)
            .removeDuplicates()
            .assign(to: \.portfolioOptions, on: self)
            .store(in: cancelBag)
        
//        titlePublisher.sink { [weak self] value in
//            if let value = value, !value.isEmpty {
//                self?.title = value
//            } else {
//                self?.title = "New portfolio"
//            }
//        }.store(in: cancelBag)
    }
    
    // MARK: - Input
    
    @Published var paid: String?
    @Published var tax: String?
    
    // MARK: - Output
    
    @Published var portfolioOptions: [PortfolioViewItem] = []
    @Published var tickerOptions: [TickerViewItem] = [
        TickerViewItem(id: "1", ticker: "AAPL"),
        TickerViewItem(id: "2", ticker: "SPY")
    ]
    
    @Published var routingState: AddDividendRouting
    @Published var title: String?
    
    // MARK: - Private
    
//    private lazy var titlePublisher: AnyPublisher<String?,Never> = {
//        $name.eraseToAnyPublisher()
//    }()
    
}

// MARK: - AddDividendViewModelInputType

extension AddDividendViewModel: AddDividendViewModelInputType {
    
    func add() {
        guard let paid = paid?.trim() else { return }
        guard let tax = tax?.trim() else { return }
        
//        guard currencyIndex >= 0 && currencyIndex < currencyOptions.count else { return }
//        let currency = currencyOptions[currencyIndex]
        
        dividendService
            .addDividend()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Swift.print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] _ in
                self?.onDisappear()
            })
            .store(in: cancelBag)
    }
    
    func onDisappear() {
        session.appState[\.routing.addDividend.isPresented] = false
    }
    
}

// MARK: - AddDividendViewModelOutputType

extension AddDividendViewModel: AddDividendViewModelOutputType {
    
}
