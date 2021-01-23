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
        _portfolioIndex = .init(initialValue: 0)
        
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
        
        $portfolioIndex
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] index in
                let portfolioId = self?.portfolioOptions[index].id
                self?.tickerOptions = session.appState[\.data.holdings]
                    .filter { $0.portfolioId == portfolioId }
                    .map { TickerViewItem(id: $0.id, ticker: $0.ticker.ticker, currencyCode: $0.ticker.currencyCode) }
        }.store(in: cancelBag)
    }
    
    deinit {
        Swift.print("[AddDividendViewModel] Deinit")
    }
    
    // MARK: - Input
    
    @Published var paid: String?
    @Published var tax: String?
    @Published var portfolioIndex: Int?
    
    // MARK: - Output
    
    @Published var portfolioOptions: [PortfolioViewItem] = []
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB")
    ]
    
    @Published var tickerOptions: [TickerViewItem] = []
    
    @Published var routingState: AddDividendRouting
    @Published var state: AddDividendViewState = .start
    @Published var title: String?
    
}

// MARK: - AddDividendViewModelInputType

extension AddDividendViewModel: AddDividendViewModelInputType {
    
    func add(portfolioIndex: Int, tickerIndex: Int, currencyIndex: Int, perShareToggle: Bool, date: Date) {
        guard let paidStr = paid?.trim().replacingOccurrences(of: ",", with: "."), let paid = Decimal(string: paidStr) else { return }
        guard let taxStr = tax?.trim(), let tax = Double(taxStr) else { return }
        let portfolioId = portfolioOptions[portfolioIndex].id
        let ticker = tickerOptions[tickerIndex].ticker
        let currency = currencyOptions[currencyIndex].id
        
        let money = MoneyDTO(value: paid, currency: Currency(code: currency))
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
    
    func cancelAction() {
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

// MARK: - AddDividendViewModelOutputType

extension AddDividendViewModel: AddDividendViewModelOutputType {
    
    func selectedTicker(_ index: Int) -> TickerViewItem? {
        guard index >= 0 && index < tickerOptions.count else { return nil }
        return tickerOptions[index]
    }
    
}

private extension AddDividendViewModel {
    
    private func loadTickers(for portfolio: PortfolioViewItem) {
        
    }
    
}
