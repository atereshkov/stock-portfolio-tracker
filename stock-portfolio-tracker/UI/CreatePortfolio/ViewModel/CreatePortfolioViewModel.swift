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
        
        titlePublisher.sink { [weak self] value in
            if let value = value, !value.isEmpty {
                self?.title = value
            } else {
                self?.title = "New portfolio"
            }
        }.store(in: cancelBag)
    }
    
    // MARK: - Input
    
    @Published var name: String?
    
    // MARK: - Output
    
    @Published var routingState: CreatePortfolioRouting
    @Published var currencyOptions = [
        CurrencyViewItem(id: "USD", name: "USD"),
        CurrencyViewItem(id: "EUR", name: "EUR")
    ]
    @Published var title: String?
    
    // MARK: - Private
    
    private lazy var titlePublisher: AnyPublisher<String?,Never> = {
        $name.eraseToAnyPublisher()
    }()
    
}

// MARK: - CreatePortfolioViewModelInputType

extension CreatePortfolioViewModel: CreatePortfolioViewModelInputType {
    
    func create(currencyIndex: Int) {
        
    }
    
    func onDisappear() {
        session.appState[\.routing.createPortfolio.isPresented] = false
    }
    
}

// MARK: - CreatePortfolioViewModelOutputType

extension CreatePortfolioViewModel: CreatePortfolioViewModelOutputType {
    
}
