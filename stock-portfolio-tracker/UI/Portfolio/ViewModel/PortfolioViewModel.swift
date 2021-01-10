//
//  PortfolioViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine

class PortfolioViewModel: BaseViewModel<PortfolioViewModelInputType, PortfolioViewModelOutputType>, PortfolioViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.portfolio)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.portfolio] = $0 }
            session.appState.map(\.routing.portfolioSettings.isPresented)
                .removeDuplicates()
                .assign(to: \.routingState.showModalSheet, on: self)
        }
    }
    
    // MARK: - Output
    
    @Published var routingState: PortfolioRouting
    
}

// MARK: - PortfolioViewModelInputType

extension PortfolioViewModel: PortfolioViewModelInputType {
    
    func settingsAction() {
        routingState.currentModalSheet = .settings
        session.appState[\.routing.portfolioSettings.isPresented] = true
    }
    
}

// MARK: - PortfolioViewModelOutputType

extension PortfolioViewModel: PortfolioViewModelOutputType {
    
}
