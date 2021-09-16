//
//  AccountViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/9/21.
//

import Combine
import SwiftUI

class AccountViewModel: BaseViewModel<AccountViewModelInputType, AccountViewModelOutputType>, AccountViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.account)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.account] = $0 }
            session.appState.map(\.routing.account)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
    }
    
    @Published var routingState: AccountRouting
    
    deinit {
        Swift.print("[AccountViewModel] Deinit")
    }
    
}

// MARK: - AccountViewModelInputType

extension AccountViewModel: AccountViewModelInputType {
    
    func onDisappear() {
        session.appState[\.routing.account.isPresented] = false
        cancelBag.cancel()
    }
    
}

// MARK: - AccountViewModelOutputType

extension AccountViewModel: AccountViewModelOutputType {
    
}
