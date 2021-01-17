//
//  PortfolioViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import SwiftUI

class PortfolioViewModel: BaseViewModel<PortfolioViewModelInputType, PortfolioViewModelOutputType>, PortfolioViewModelType {
    
    private let holdingService: HoldingServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.holdingService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.portfolio)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.portfolio] = $0 }
            
            session.appState.map(\.data.holdings)
                .removeDuplicates()
                .assign(to: \.holdings, on: self)
        }
    }
    
    deinit {
        Swift.print("[PortfolioViewModel] Deinit")
    }
    
    // MARK: - Input
    
    @Published var portfolio: PortfolioViewItem?
    
    // MARK: - Output
    
    @Published var routingState: PortfolioRouting
    @Published var holdings: [HoldingViewItem] = []
    
}

// MARK: - PortfolioViewModelInputType

extension PortfolioViewModel: PortfolioViewModelInputType {
    
    func settingsAction() {
        routingState.currentModalSheet = .settings
        routingState.showModalSheet = true
    }
    
    func addTickerAction() {
        routingState.currentModalSheet = .addTicker
        routingState.showModalSheet = true
    }
    
    func onAppear() {
        holdings = holdings.filter { $0.portfolioId == portfolio?.id }
    }
    
    func onDisappear() {
        cancelBag.cancel()
    }
    
}

// MARK: - PortfolioViewModelOutputType

extension PortfolioViewModel: PortfolioViewModelOutputType {
    
}

extension PortfolioViewModel: SearchTickerDelegate {
    
    func onTickerSelected(_ ticker: TickerViewItem) {
        let dto = HoldingDTO(id: ticker.id, ticker: ticker.ticker, createdAt: Date(), updatedAt: Date(), portfolioId: portfolio?.id ?? "")
        // TODO use AddHoldingDTO
        
        holdingService
            .addHolding(holding: dto, portfolioId: portfolio?.id ?? "")
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
    
}
