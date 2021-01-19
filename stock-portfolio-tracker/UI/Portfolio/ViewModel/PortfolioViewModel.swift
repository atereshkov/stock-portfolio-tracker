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
        }
        
        let itemsPublisher = session.appState.map(\.data.holdings)
        let portfolioPublisher = $portfolio
        Publishers.CombineLatest(itemsPublisher, portfolioPublisher).sink { [weak self] items, portfolio in
            self?.holdings = items.filter { $0.portfolioId == portfolio?.id }
        }.store(in: cancelBag)
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
        routingState.currentModalSheet = nil
        routingState.showModalSheet = false
        
        let dto = AddHoldingDTO(id: ticker.id, ticker: ticker.ticker)
        
        holdingService
            .addHolding(holding: dto, portfolioId: portfolio?.id ?? "")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: cancelBag)
    }
    
}
