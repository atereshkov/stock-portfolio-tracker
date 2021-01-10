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
    
    @Published var routingState: AddDividendRouting
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

// MARK: - AddDividendViewModelInputType

extension AddDividendViewModel: AddDividendViewModelInputType {
    
    func create(currencyIndex: Int) {
        guard let name = name?.trim() else { return }
        
        guard currencyIndex >= 0 && currencyIndex < currencyOptions.count else { return }
        let currency = currencyOptions[currencyIndex]
        
        dividendService
            .addDividend()
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
    
    func onDisappear() {
        session.appState[\.routing.createPortfolio.isPresented] = false
    }
    
}

// MARK: - AddDividendViewModelOutputType

extension AddDividendViewModel: AddDividendViewModelOutputType {
    
}
