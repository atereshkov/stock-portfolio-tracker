//
//  PortfolioSettingsViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine
import SwiftUI

class PortfolioSettingsViewModel: BaseViewModel<PortfolioSettingsViewModelInputType, PortfolioSettingsViewModelOutputType>, PortfolioSettingsViewModelType {
    
    private var cancelBag = CancelBag()
    
    override init(session: SessionType) {
        _routingState = .init(initialValue: session.appState.value.routing.portfolioSettings)
        super.init(session: session)
        
        cancelBag.collect {
            $routingState
                .sink { session.appState[\.routing.portfolioSettings] = $0 }
            session.appState.map(\.routing.portfolioSettings)
                .removeDuplicates()
                .assign(to: \.routingState, on: self)
        }
    }
    
    @Published var routingState: PortfolioSettingsRouting
    
}

// MARK: - PortfolioSettingsViewModelInputType

extension PortfolioSettingsViewModel: PortfolioSettingsViewModelInputType {
    
    func onDisappear() {
        session.appState[\.routing.portfolioSettings.isPresented] = false
    }
    
}

// MARK: - PortfolioSettingsViewModelOutputType

extension PortfolioSettingsViewModel: PortfolioSettingsViewModelOutputType {
    
}
