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
    
    deinit {
        Swift.print("[AddDividendViewModel] Deinit")
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
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB")
    ]
    
    @Published var routingState: AddDividendRouting
    @Published var state: AddDividendViewState = .start
    @Published var title: String?
    
    // MARK: - Private
    
//    private lazy var titlePublisher: AnyPublisher<String?,Never> = {
//        $name.eraseToAnyPublisher()
//    }()
    
}

// MARK: - AddDividendViewModelInputType

extension AddDividendViewModel: AddDividendViewModelInputType {
    
    func add(portfolioIndex: Int, tickerIndex: Int, currencyIndex: Int, perShareToggle: Bool, date: Date) {
        guard let paidStr = paid?.trim().replacingOccurrences(of: ",", with: "."), let paid = Decimal(string: paidStr) else { return }
        guard let taxStr = tax?.trim(), let tax = Double(taxStr) else { return }
        let portfolioId = portfolioOptions[portfolioIndex].id
        let ticker = tickerOptions[tickerIndex].ticker
        let currency = currencyOptions[currencyIndex].id
        
        let money = MoneyDTO(value: paid, currency: currency)
        let dto = AddDividendDTO(ticker: ticker, date: date, paid: money, tax: tax)
        
        state = .loading
        
        dividendService
            .addDividend(dto, portfolioId: portfolioId)
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
    
    func onAppear() {
        routingState.isPresented = true
    }
    
    func onDisappear() {
        routingState.isPresented = false
        cancelBag.cancel()
    }
    
}

// MARK: - AddDividendViewModelOutputType

extension AddDividendViewModel: AddDividendViewModelOutputType {
    
}
