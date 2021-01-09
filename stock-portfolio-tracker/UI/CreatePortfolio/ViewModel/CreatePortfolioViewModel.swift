//
//  CreatePortfolioViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Combine
import SwiftUI

class CreatePortfolioViewModel: BaseViewModel<CreatePortfolioViewModelInputType, CreatePortfolioViewModelOutputType>, CreatePortfolioViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.createPortfolio)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.createPortfolio] = $0 }
            session.appState.map(\.routing.createPortfolio)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
    }
    
    @Published var routingState: CreatePortfolioRouting
    
}

// MARK: - CreatePortfolioViewModelInputType

extension CreatePortfolioViewModel: CreatePortfolioViewModelInputType {
    
    func closeAction() {
        session.appState[\.routing.createPortfolio.isPresented] = false
    }
    
    func onDisappear() {
        session.appState[\.routing.createPortfolio.isPresented] = false
    }
    
}

// MARK: - CreatePortfolioViewModelOutputType

extension CreatePortfolioViewModel: CreatePortfolioViewModelOutputType {
    
}
