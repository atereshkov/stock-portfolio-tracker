//
//  FeesViewModel.swift
//  stock-portfolio-tracker
//
//  Created by nb-058-41b on 1/10/21.
//

import Combine

class FeesViewModel: BaseViewModel<FeesViewModelInputType, FeesViewModelOutputType>, FeesViewModelType {
    
    override init(session: SessionType) {
        super.init(session: session)
    }
    
}

// MARK: - FeesViewModelInputType

extension FeesViewModel: FeesViewModelInputType {
    
}

// MARK: - FeesViewModelOutputType

extension FeesViewModel: FeesViewModelOutputType {
    
}
