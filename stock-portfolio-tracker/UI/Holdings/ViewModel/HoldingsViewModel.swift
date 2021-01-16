//
//  HoldingsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/16/21.
//

import Combine
import SwiftUI

class HoldingsViewModel: BaseViewModel<HoldingsViewModelInputType, HoldingsViewModelOutputType>, HoldingsViewModelType {
    
    private let holdingService: HoldingServiceType
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        self.holdingService = session.resolve()
        
        _routingState = .init(initialValue: session.appState.value.routing.holdings)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.holdings] = $0 }
            
            session.appState.map(\.routing.addLot.isPresented)
                .removeDuplicates()
                .assign(to: \.routingState.showModalSheet, on: self)
        }
        
        session.appState.map(\.data.lots)
            .compactMap { $0 }
            .sink { [weak self] lots in
                guard let id = self?.holding?.id else { return }
                self?.lots = lots[id] ?? []
            }
            .store(in: cancelBag)
        
        $holding
            .compactMap { $0 }
            .sink { [weak self] holding in
                self?.lots = self?.session.appState[\.data.lots][holding.id] ?? []
        }.store(in: cancelBag)
    }
    
    deinit {
        Swift.print("[HoldingsViewModel] Deinit")
    }
    
    // MARK: - Input
    
    @Published var portfolio: PortfolioViewItem?
    @Published var holding: HoldingViewItem?
    
    // MARK: - Output
    
    @Published var routingState: HoldingsRouting
    @Published var lots: [LotViewItem] = []
    
}

// MARK: - HoldingsViewModelInputType

extension HoldingsViewModel: HoldingsViewModelInputType {
    
    func addLotAction() {
        routingState.currentModalSheet = .addLot
        session.appState[\.routing.addLot.isPresented] = true
    }
    
    func onAppear() {
        guard let holdingId = holding?.id else { return }
        guard let portfolioId = portfolio?.id else { return }
        _ = holdingService.loadLots(portfolioId: portfolioId, holdingId: holdingId)
    }
    
    func onDisappear() {
        cancelBag.cancel()
    }
    
}

// MARK: - HoldingsViewModelOutputType

extension HoldingsViewModel: HoldingsViewModelOutputType {
    
}
