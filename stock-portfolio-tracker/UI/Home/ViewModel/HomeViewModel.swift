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
            session.appState.map(\.routing.createPortfolio.isPresented)
                .removeDuplicates()
                .assign(to: \.routingState.showModalSheet, on: self)
        }
    }
    
    // MARK: - Output
    
    @Published var routingState: HomeRouting
    
}

// MARK: - HomeViewModelInputType

extension HomeViewModel: HomeViewModelInputType {
    
    func newPortfolioAction() {
        session.appState[\.routing.createPortfolio.isPresented] = true
    }
    
}

// MARK: - MainViewModelOutputType

extension HomeViewModel: HomeViewModelOutputType {
    
}
