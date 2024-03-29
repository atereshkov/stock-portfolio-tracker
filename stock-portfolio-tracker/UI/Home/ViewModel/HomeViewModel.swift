//
//  HomeViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/7/21.
//

import Combine

class HomeViewModel: BaseViewModel<HomeViewModelInputType, HomeViewModelOutputType>, HomeViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.home)
        
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.home] = $0 }
            
            session.appState.map(\.data.portfolios)
                .removeDuplicates()
                .assign(to: \.portfolios, on: self)
        }
    }
    
    // MARK: - Output
    
    @Published var routingState: HomeRouting
    @Published var portfolios: [PortfolioViewItem] = []
    
}

// MARK: - HomeViewModelInputType

extension HomeViewModel: HomeViewModelInputType {
    
    func newPortfolioAction() {
        routingState.currentModalSheet = .createPortfolio
        routingState.showModalSheet = true
    }
    
    func accountAction() {
        routingState.currentModalSheet = .account
        routingState.showModalSheet = true
    }
    
}

// MARK: - MainViewModelOutputType

extension HomeViewModel: HomeViewModelOutputType {
    
}
