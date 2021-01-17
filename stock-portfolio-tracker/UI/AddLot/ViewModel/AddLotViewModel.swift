//
//  AddLotViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Combine
import SwiftUI

class AddLotViewModel: BaseViewModel<AddLotViewModelInputType, AddLotViewModelOutputType>, AddLotViewModelType {
    
    private let holdingService: HoldingServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.holdingService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.addLot)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.addLot] = $0 }
            session.appState.map(\.routing.addLot)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
        
        $holding
            .sink { [weak self] in self?.title = $0?.ticker ?? "" }
            .store(in: cancelBag)
    }
    
    deinit {
        Swift.print("[AddLotViewModel] Deinit")
    }
    
    // MARK: - Input
    
    @Published var portfolio: PortfolioViewItem?
    @Published var holding: HoldingViewItem?
    
    @Published var cost: String?
    @Published var fee: String?
    @Published var shares: String?
    
    // MARK: - Output
    
    @Published var feeCurrencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR"),
        CurrencyViewItem(id: "RUB", name: "RUB"),
        CurrencyViewItem(id: "BYN", name: "BYN")
    ]
    
    @Published var routingState: AddLotRouting
    @Published var state: AddLotViewState = .start
    @Published var title: String?
    
}

// MARK: - AddLotViewModelInputType

extension AddLotViewModel: AddLotViewModelInputType {
    
    func add(currencyIndex: Int, date: Date) {
        guard let portfolioId = portfolio?.id, let holdingId = holding?.id else { return }
        guard let costStr = cost?.trim().replacingOccurrences(of: ",", with: "."), let cost = Decimal(string: costStr) else { return }
        guard let feeStr = fee?.trim().replacingOccurrences(of: ",", with: "."), let fee = Decimal(string: feeStr) else { return }
        guard let sharesStr = shares, let sharesNumber = Int(sharesStr) else { return }
        guard let ticker = holding?.ticker else { return }
        guard let costCurrency = portfolio?.currency else { return }
        let feeCurrency = feeCurrencyOptions[currencyIndex].id
        
        let costDTO = MoneyDTO(value: cost, currency: costCurrency)
        let feeDTO = MoneyDTO(value: fee, currency: feeCurrency)
        let dto = AddLotDTO(ticker: ticker, date: date, cost: costDTO, fee: feeDTO, shares: sharesNumber)
        
        state = .loading
        
        holdingService
            .addLot(lot: dto, portfolioId: portfolioId, holdingId: holdingId)
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

// MARK: - AddLotViewModelOutputType

extension AddLotViewModel: AddLotViewModelOutputType {
    
}
