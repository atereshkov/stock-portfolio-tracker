//
//  DividendViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import SwiftUI

class DividendViewModel: BaseViewModel<DividendViewModelInputType, DividendViewModelOutputType>, DividendViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.dividend)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.dividend] = $0 }
            session.appState.map(\.routing.dividend)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
    }
    
    deinit {
        Swift.print("[DividendViewModel] Deinit")
    }
    
    @Published var routingState: DividendRouting
    
}

// MARK: - DividendViewModelInputType

extension DividendViewModel: DividendViewModelInputType {
    
    func onDisappear() {
        session.appState[\.routing.dividend.isPresented] = false
        cancelBag.cancel()
    }
    
}

// MARK: - DividendViewModelOutputType

extension DividendViewModel: DividendViewModelOutputType {
    
}
