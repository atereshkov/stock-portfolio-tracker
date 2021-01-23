//
//  AddFeeViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/21/21.
//

import Combine
import SwiftUI

class AddFeeViewModel: BaseViewModel<AddFeeViewModelInputType, AddFeeViewModelOutputType>, AddFeeViewModelType {
    
    private let feeService: FeeServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.feeService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.addFee)
        _portfolioIndex = .init(initialValue: 0)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.addFee] = $0 }
            session.appState.map(\.routing.addFee)
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
                    .map { TickerViewItem(id: $0.id, ticker: $0.ticker) }
        }.store(in: cancelBag)
        
        $typeIndex
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] index in
                self?.showPortfolio = index != 0 || index != 1
            }.store(in: cancelBag)
    }
    
    deinit {
        Swift.print("[AddFeeViewModel] Deinit")
    }
    
    // MARK: - Input
    
    @Published var paid: String?
    @Published var tax: String?
    @Published var portfolioIndex: Int?
    @Published var typeIndex: Int?
    
    // MARK: - Output
    
    @Published var tickerOptions: [TickerViewItem] = []
    @Published var portfolioOptions: [PortfolioViewItem] = []
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB")
    ]
    @Published var typeOptions: [FeeTypeViewItem] = [
        FeeTypeViewItem(id: "monthly", type: "monthly"),
        FeeTypeViewItem(id: "other", type: "other"),
        FeeTypeViewItem(id: "buy", type: "buy"),
        FeeTypeViewItem(id: "sell", type: "sell")
    ]
    
    @Published var routingState: AddFeeRouting
    @Published var state: AddFeeViewState = .start
    @Published var title: String?
    @Published var showPortfolio: Bool = false
    
}

// MARK: - AddFeeViewModelInputType

extension AddFeeViewModel: AddFeeViewModelInputType {
    
    func add(portfolioIndex: Int, tickerIndex: Int, currencyIndex: Int, date: Date) {
        guard let paidStr = paid?.trim().replacingOccurrences(of: ",", with: "."), let paid = Decimal(string: paidStr) else { return }
        guard let typeIndex = typeIndex else { return }
        let portfolioId = portfolioOptions[portfolioIndex].id
        let tickerId = tickerOptions[tickerIndex].id
        let ticker = tickerOptions[tickerIndex].ticker
        let currency = currencyOptions[currencyIndex].id
        let type = typeOptions[typeIndex].id
        
        let fee = MoneyDTO(value: paid, currency: Currency(code: currency))
        let dto = AddFeeDTO(type: type, ticker: ticker, date: date, fee: fee)
        
        state = .loading
        
        feeService
            .addFee(dto, portfolioId: portfolioId, tickerId: tickerId)
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

// MARK: - AddFeeViewModelOutputType

extension AddFeeViewModel: AddFeeViewModelOutputType {
    
    func selectedTicker(_ index: Int) -> TickerViewItem? {
        guard index >= 0 && index < tickerOptions.count else { return nil }
        return tickerOptions[index]
    }
    
}
