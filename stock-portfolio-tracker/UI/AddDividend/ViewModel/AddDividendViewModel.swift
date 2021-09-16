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
        
        $ticker
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] ticker in
                self?.holding = session.appState[\.data.holdings]
                    .first(where: { $0.id == ticker })
                
                self?.currencyName = self?.holding?.ticker.currencyCode
                self?.currencySelectionDisabled = self?.holding != nil
        }.store(in: cancelBag)
        
        $currencyIndex
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] index in
                self?.currencyName = self?.currencyOptions[index].name
                self?.currencySelectionDisabled = false
        }.store(in: cancelBag)
    }
    
    deinit {
        Swift.print("[AddDividendViewModel] Deinit")
    }
    
    // MARK: - Input
    
    @Published var paid: String?
    @Published var tax: String?
    @Published var ticker: String?
    @Published var currencyIndex: Int?
    
    // MARK: - Output
    
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB"),
        CurrencyViewItem(id: "BYN", name: "BYN")
    ]
    
    @Published var routingState: AddDividendRouting
    @Published var state: AddDividendViewState = .start
    @Published var title: String?
    @Published var currencyName: String?
    @Published var currencySelectionDisabled: Bool = true
    
    // MARK: - Private
    
    private var holding: HoldingViewItem?
    
}

// MARK: - AddDividendViewModelInputType

extension AddDividendViewModel: AddDividendViewModelInputType {
    
    func add(portfolioIndex: Int, tickerIndex: Int, perShareToggle: Bool, date: Date) {
        guard let paidStr = paid?.trim().replacingOccurrences(of: ",", with: "."), let paid = Decimal(string: paidStr) else { return }
        guard let taxStr = tax?.trim(), let tax = Double(taxStr) else { return }
        guard let ticker = ticker?.trim() else { return }
        let portfolioId = holding?.portfolioId
        let currency = holding?.ticker.currencyCode ?? currencyName ?? ""
        
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
    
}

private extension AddDividendViewModel {
    
    private func loadTickers(for portfolio: PortfolioViewItem) {
        
    }
    
}
